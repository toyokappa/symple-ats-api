class Candidate < ApplicationRecord
  has_many :recruitment_histories, dependent: :destroy
  belongs_to :recruitment_selection
  belongs_to :recruiter, optional: true
  belongs_to :medium, optional: true
  belongs_to :position, optional: true
end
