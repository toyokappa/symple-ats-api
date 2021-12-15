class RecruitmentHistoryBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :selected_at, :result, :recruitment_selection_id, :candidate_id
  end
end
