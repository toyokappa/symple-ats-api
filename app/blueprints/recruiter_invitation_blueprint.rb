class RecruiterInvitationBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :email, :role
  end
end
