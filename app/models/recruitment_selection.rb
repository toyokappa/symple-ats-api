class RecruitmentSelection < ApplicationRecord
  belongs_to :recruitment_project
  acts_as_list scope: :recruitment_project
end
