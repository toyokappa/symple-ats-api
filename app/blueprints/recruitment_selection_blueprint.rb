class RecruitmentSelectionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :position
    field :list do
      []
    end
  end
end
