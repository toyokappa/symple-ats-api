class RecruitmentSelectionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :position
    association :candidates, blueprint: CandidateBlueprint, view: :normal
  end
end
