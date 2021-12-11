class RecruitmentHistory < ApplicationRecord
  belongs_to :recruitment_selection
  belongs_to :candidate

  enum result: { pass: 10, failure: 20 }
end
