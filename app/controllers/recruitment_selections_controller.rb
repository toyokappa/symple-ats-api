class RecruitmentSelectionsController < ApplicationController
  def index
    # TODO: Pagingについて考える
    selections = RecruitmentSelection.all.includes(candidates: [:recruiter, :channel, :position, :recruitment_histories])
    render json: RecruitmentSelectionBlueprint.render(selections, view: :normal)
  end
end
