class RecruitmentSelectionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :selection_type, :position
    association :candidates, blueprint: CandidateBlueprint, view: :normal
  end
end
