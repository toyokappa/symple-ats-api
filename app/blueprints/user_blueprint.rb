class UserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :nickname, :email, :role, :level
  end
end
