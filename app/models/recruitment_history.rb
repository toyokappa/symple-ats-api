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
class RecruitmentHistory < ApplicationRecord
  belongs_to :recruitment_selection
  belongs_to :candidate

  enum result: { pass: 10, failure: 20 }
end
