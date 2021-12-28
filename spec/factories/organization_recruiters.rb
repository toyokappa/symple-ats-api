# == Schema Information
#
# Table name: organization_recruiters
#
#  id              :bigint           not null, primary key
#  role            :integer
#  organization_id :bigint           not null
#  recruiter_id    :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :organization_recruiter do
    organization
    recruiter
    role { [10, 20, 30].sample }
  end
end
