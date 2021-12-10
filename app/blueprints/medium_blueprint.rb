class MediumBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :category, :automation, :apply_token
  end
end
