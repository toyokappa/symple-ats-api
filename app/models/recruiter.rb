# frozen_string_literal: true

# == Schema Information
#
# Table name: recruiters
#
#  id                     :bigint           not null, primary key
#  provider               :string(255)      default("email"), not null
#  uid                    :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  image                  :string(255)
#  email                  :string(255)
#  level                  :integer          default(1)
#  tokens                 :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'google/api_client/client_secrets'

class Recruiter < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :organization_recruiters, dependent: :destroy
  has_many :organizations, through: :organization_recruiters
  has_many :recruitment_evaluations, dependent: :destroy

  def role(organization)
    organization_recruiters.find_by(organization: organization).role
  end

  def google_authenticated
    google_access_token.present?
  end

  def get_busy_times
    secrets = google_client_secret

    free_busy_request = Google::Apis::CalendarV3::FreeBusyRequest.new(
      time_min: Time.zone.now.xmlschema,
      time_max: (Time.zone.now + 2.weeks).xmlschema,
      time_zone: 'tokyo',
      items: [{ id: 'primary' }],
    )

    cal_service = google_calendar_service(secrets)
    res = cal_service.query_freebusy(free_busy_request)
    res.calendars['primary'].busy.map do |item|
      {
        start: item.start,
        end: item.end,
      }
    end
  end

  def create_event(event_params)
    secrets = google_client_secret

    start_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: Time.zone.parse(event_params[:start]).xmlschema,
    )
    end_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: Time.zone.parse(event_params[:end]).xmlschema,
    )
    new_event = Google::Apis::CalendarV3::Event.new(
      summary: event_params[:summary],
      start: start_time,
      end: end_time,
    )

    cal_service = google_calendar_service(secrets)
    cal_service.insert_event(
      'primary',
      new_event,
    )
  end

  private

  def google_client_secret
    Google::APIClient::ClientSecrets.new(
      web: {
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        access_token: google_access_token,
        refresh_token: google_refresh_token,
      }
    )
  end

  def google_calendar_service(secrets)
    cal_service = Google::Apis::CalendarV3::CalendarService.new
    cal_service.authorization = secrets.to_authorization
    cal_service.authorization.refresh!
    cal_service
  end
end
