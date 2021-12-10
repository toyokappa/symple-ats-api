class RecruitmentSelectionsController < ApplicationController
  def index
    # TODO: Pagingについて考える
    selections = RecruitmentSelection.all.includes(:candidates)
    render json: RecruitmentSelectionBlueprint.render(selections, view: :normal)
  end
end
