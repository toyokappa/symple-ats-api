class RecruitmentHistoriesController < ApplicationController
  def update
    history = RecruitmentHistory.find_by(id: params[:id])
    return render json: status_404, status: 404 if history.blank?
    return render json: status_400, status: 400 if history_params.blank?

    if history.update(history_params)
      render json: RecruitmentHistoryBlueprint.render(history, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def history_params
    params.fetch(:history, {}).permit(
      :result,
      :selected_at,
    )
  end
end
