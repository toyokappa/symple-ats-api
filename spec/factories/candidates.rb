# == Schema Information
#
# Table name: candidates
#
#  id                       :bigint           not null, primary key
#  name                     :string(255)
#  list_position            :integer
#  recruitment_selection_id :bigint           not null
#  recruiter_id             :bigint
#  channel_id               :bigint
#  position_id              :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
FactoryBot.define do
  factory :candidate do
    sequence(:name) {|n| "プロジェクト#{n}" }
    recruitment_selection
    recruiter
    channel
    position
  end
end
