class CandidateBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :recruitment_selection_id, :list_position, :recruiter_id, :channel_id, :position_id, :resume_files
    association :recruitment_histories, blueprint: RecruitmentHistoryBlueprint, view: :normal
  end
end
