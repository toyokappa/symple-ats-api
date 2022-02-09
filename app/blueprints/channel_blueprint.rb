class ChannelBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :category, :automation, :apply_token, :organization_unique_id
  end
end
