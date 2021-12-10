class PositionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :internal_name, :external_name, :status
  end
end
