class CandidateBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :recruitment_selection_id, :list_position, :recruiter_id, :channel_id, :position_id
    association :recruiter, blueprint: RecruiterBlueprint, view: :normal
    association :channel, blueprint: ChannelBlueprint, view: :normal
    association :position, blueprint: PositionBlueprint, view: :normal
    association :recruitment_histories, blueprint: RecruitmentHistoryBlueprint, view: :normal
  end
end
