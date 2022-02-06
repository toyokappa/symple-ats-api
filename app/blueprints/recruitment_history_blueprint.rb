class RecruitmentHistoryBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :selected_at, :result, :recruitment_selection_id, :candidate_id
    association :recruitment_evaluations, blueprint: RecruitmentEvaluationBlueprint, view: :normal
  end
end
