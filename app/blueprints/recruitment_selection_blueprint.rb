class RecruitmentSelectionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :selection_type, :position, :recruitment_project_id
    association :candidates, blueprint: CandidateBlueprint, view: :normal
  end
end
