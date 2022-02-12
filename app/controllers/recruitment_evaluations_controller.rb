class RecruitmentEvaluationsController < ApplicationController
  before_action :find_history

  def create
    evaluation = @history.recruitment_evaluations.build(evaluation_params)
    if evaluation.save
      render json: RecruitmentEvaluationBlueprint.render(evaluation, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def update
    evaluation = @history.recruitment_evaluations.find_by(id: params[:id])
    return render json: status_404, status: 404 if evaluation.blank?
    return render json: status_400, status: 400 if evaluation_params.blank?

    if evaluation.update(evaluation_params)
      render json: RecruitmentEvaluationBlueprint.render(evaluation, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def destroy
    evaluation = @history.recruitment_evaluations.find_by(id: params[:id])
    return render json: status_404, status: 404 if evaluation.blank?

    evaluation.destroy!
    render json: RecruitmentEvaluationBlueprint.render(evaluation, view: :normal)
  end

  private

  def find_history
    @history = RecruitmentHistory.find_by(id: params[:recruitment_history_id])
    return render json: status_404, status: 404 if @history.blank?
  end

  def evaluation_params
    params.fetch(:evaluation, {}).permit(
      :recruiter_id,
      :result,
      :input_at,
      :description,
    )
  end
end
