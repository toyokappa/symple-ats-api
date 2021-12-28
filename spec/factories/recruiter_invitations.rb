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
    email { "MyString" }
    role { 1 }
    token { "MyString" }
    expired_at { "2021-12-27 10:13:16" }
  end
end
