class RecruitmentSelection < ApplicationRecord
  has_many :candidates, dependent: :destroy

  belongs_to :recruitment_project
  acts_as_list scope: :recruitment_project

  enum selection_type: { document: 10, interview: 20, offer: 30, consent: 40, failure: 50, decline: 60, other: 100 }, _prefix: true
end
