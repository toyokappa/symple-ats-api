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
class RecruitmentSelection < ApplicationRecord
  has_many :candidates, -> { order(:list_position) }, dependent: :destroy
  has_many :recruitment_histories, dependent: :destroy

  belongs_to :recruitment_project
  acts_as_list scope: :recruitment_project

  enum selection_type: { document: 10, interview: 20, offer: 30, consent: 40, failure: 50, decline: 60, other: 100 }, _prefix: true
end
