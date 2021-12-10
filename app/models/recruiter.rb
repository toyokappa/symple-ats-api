# frozen_string_literal: true

class Recruiter < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum role: { viewer: 10, interviewer: 20, admin: 30 }, _prefix: true
end
