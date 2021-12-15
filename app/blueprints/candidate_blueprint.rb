class CandidateBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :recruitment_selection_id
    association :recruiter, blueprint: RecruiterBlueprint, view: :normal
    association :medium, blueprint: MediumBlueprint, view: :normal
    association :position, blueprint: PositionBlueprint, view: :normal
    association :recruitment_histories, blueprint: RecruitmentHistoryBlueprint, view: :normal
  end
end
