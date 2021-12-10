class RecruitmentSelection < ApplicationRecord
  has_many :candidates, dependent: :destroy

  belongs_to :recruitment_project
  acts_as_list scope: :recruitment_project
end
