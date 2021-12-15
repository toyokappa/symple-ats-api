class RecruitmentProject < ApplicationRecord
  has_many :recruitment_selections, -> { order(:position) }, dependent: :destroy
end
