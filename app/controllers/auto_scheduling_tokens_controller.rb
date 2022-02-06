class AutoSchedulingTokensController < ApplicationController
  def create
    history = RecruitmentHistory.find_by(id: params[:recruitment_history_id])
    return render json: status_404, status: 404 if history.blank?

    history.update_auto_scheduling_token
    render json: RecruitmentHistoryBlueprint.render(history, view: :normal)
  end
end
