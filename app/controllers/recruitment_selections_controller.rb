class RecruitmentSelectionsController < ApplicationController
  def index
    # TODO: Pagingについて考える
    selections = RecruitmentSelection.all
    render json: RecruitmentSelectionBlueprint.render(selections, view: :normal)
  end
end
