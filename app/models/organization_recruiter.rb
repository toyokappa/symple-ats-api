class OrganizationRecruiter < ApplicationRecord
  belongs_to :organization
  belongs_to :recruiter
end
