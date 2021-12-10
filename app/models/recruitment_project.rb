class RecruitmentProject < ApplicationRecord
  has_many :recruitment_selections, -> { order(position: :asc), dependent: :destroy
end
