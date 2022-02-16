class RecruitmentHistoryBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :selected_at, :result, :auto_scheduling_token, :recruitment_selection_id, :candidate_id
    association :recruitment_evaluations, blueprint: RecruitmentEvaluationBlueprint, view: :normal
  end

  view :with_candidate do
    include_view :normal
    association :candidate, blueprint: CandidateBlueprint, view: :without_associations
  end
end
