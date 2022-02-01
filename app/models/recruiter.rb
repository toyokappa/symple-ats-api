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

  def role(organization)
    organization_recruiters.find_by(organization: organization).role
  end

  def google_authenticated
    google_access_token.present?
  end

  def schedules
    secrets = Google::APIClient::ClientSecrets.new(
      web: {
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        access_token: google_access_token,
        refresh_token: google_refresh_token,
      }
    )

    free_busy_request = Google::Apis::CalendarV3::FreeBusyRequest.new(
      time_min: Time.zone.now.xmlschema,
      time_max: (Time.zone.now + 2.weeks).xmlschema,
      time_zone: 'tokyo',
      items: [{ id: 'primary' }],
    )

    cal_service = Google::Apis::CalendarV3::CalendarService.new
    cal_service.authorization = secrets.to_authorization
    cal_service.authorization.refresh!
    res = cal_service.query_freebusy(free_busy_request)
    busy_times = res.calendars['primary'].busy.map do |item|
      {
        start: item.start,
        end: item.end,
      }
    end
    change_schedule_to_bit(busy_times)
  end

  def change_schedule_to_bit(busy_times)
    schedule_bit_data = {}
    busy_times.each do |time|
      date, bit_data = change_event_to_bit(time)
      if schedule_bit_data.has_key?(date)
        schedule_bit_data[date] = make_logical_sum(schedule_bit_data[date], bit_data)
      else
        schedule_bit_data[date] = bit_data
      end
    end
    schedule_bit_data
  end

  def change_event_to_bit(busy_time)
    event_start = busy_time[:start].to_i
    event_end = busy_time[:end].to_i
    date = busy_time[:start].to_date

    day_start = (date.in_time_zone + 8.hours).to_i
    day_end = (date.in_time_zone + 20.hours).to_i

    # 30分ごと
    segment_count = (day_end - day_start) / 60 / 60 * 2
    day_pointer = day_start

    bit_data = ''
    segment_count.times do
      # 15分毎に予定があるかどうかを確認しあれば該当の30分は予定ありとする
      condition1 = event_start <= day_pointer && day_pointer < event_end
      day_pointer += 900
      condition2 = event_start <= day_pointer && day_pointer < event_end
      day_pointer += 900

      if condition1 || condition2
        bit_data += '1'
      else
        bit_data += '0'
      end
    end
    [date.to_s, bit_data]
  end

  def make_logical_sum(bits1, bits2)
    bit_array1 = bits1.split('')
    bit_array2 = bits2.split('')
    bit_array1.map.with_index do |bit, i|
      if bit == '0' && bit_array2[i] == '0'
        '0'
      else
        '1'
      end
    end.join
  end
end
