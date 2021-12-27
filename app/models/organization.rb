# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  unique_id  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  has_many :organization_recruiters, dependent: :destroy
  has_many :recruiters, through: :organization_recruiters
  has_many :channels, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :recruitment_projects, dependent: :destroy
end
