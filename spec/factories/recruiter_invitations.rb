# == Schema Information
#
# Table name: recruiter_invitations
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  role            :integer
#  token           :string(255)
#  expired_at      :datetime
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :recruiter_invitation do
    sequence(:email) {|n| "recruiter#{n}@symple.com" }
    role { [10, 20, 30].sample }
    organization
  end
end
