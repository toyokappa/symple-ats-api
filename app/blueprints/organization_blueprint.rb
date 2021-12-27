class OrganizationBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :unique_id
  end
end
