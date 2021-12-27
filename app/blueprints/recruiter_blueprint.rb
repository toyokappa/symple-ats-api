class RecruiterBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :nickname, :email, :role, :level
  end

  view :with_organization do
    include_view :normal
    association :organizations, blueprint: OrganizationBlueprint, view: :normal
    association :organization, blueprint: OrganizationBlueprint, view: :normal do |_, options|
      options[:selected_organization]
    end
  end
end
