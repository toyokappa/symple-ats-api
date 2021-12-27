# == Schema Information
#
# Table name: organization_recruiters
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  recruiter_id    :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class OrganizationRecruiter < ApplicationRecord
  belongs_to :organization
  belongs_to :recruiter
end
