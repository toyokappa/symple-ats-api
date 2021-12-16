# == Schema Information
#
# Table name: recruitment_selections
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  selection_type         :integer
#  position               :integer
#  recruitment_project_id :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
FactoryBot.define do
  factory :recruitment_selection do
    sequence(:name) {|n| "選考#{n}" }
    selection_type { [10, 20, 30, 40, 50, 60, 100].sample }
    recruitment_project
  end
end
