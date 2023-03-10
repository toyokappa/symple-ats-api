# == Schema Information
#
# Table name: recruitment_projects
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
FactoryBot.define do
  factory :recruitment_project do
    sequence(:name) {|n| "プロジェクト#{n}" }
    organization
  end
end
