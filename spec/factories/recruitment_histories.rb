# == Schema Information
#
# Table name: recruitment_histories
#
#  id                       :bigint           not null, primary key
#  selected_at              :datetime
#  result                   :integer
#  recruitment_selection_id :bigint           not null
#  candidate_id             :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
FactoryBot.define do
  factory :recruitment_history do
    result { [10, 20].sample }
    recruitment_selection
    candidate
  end
end
