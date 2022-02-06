class RecruitmentEvaluationBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :recruitment_history_id, :recruiter_id, :result, :input_at, :description
  end
end
