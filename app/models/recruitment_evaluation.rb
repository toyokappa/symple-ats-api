class RecruitmentEvaluation < ApplicationRecord
  belongs_to :recruitment_history
  belongs_to :recruiter

  enum result: { pass: 10, failure: 20 }
end
