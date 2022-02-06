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
  has_many :recruitment_evaluations, dependent: :destroy
  belongs_to :recruitment_selection
  belongs_to :candidate

  enum result: { pass: 10, failure: 20 }

  def update_auto_scheduling_token
    self.auto_scheduling_token = loop do
      tmp_token = SecureRandom.alphanumeric(24)
      break tmp_token unless self.class.find_by(auto_scheduling_token: tmp_token)
    end

    self.save
  end
end
