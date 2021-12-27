class Organization < ApplicationRecord
  has_many :organization_recruiters, dependent: :destroy
  has_many :recruiters, through: :organization_recruiters
end
