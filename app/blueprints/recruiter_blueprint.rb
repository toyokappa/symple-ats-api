class RecruiterBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :nickname, :email
    field :role do |recruiter, options|
      recruiter.role(options[:current_org])
    end
  end

  view :with_organization do
    include_view :normal
    association :organizations, blueprint: OrganizationBlueprint, view: :normal
    association :organization, blueprint: OrganizationBlueprint, view: :normal do |_, options|
      options[:current_org]
    end
  end
end
