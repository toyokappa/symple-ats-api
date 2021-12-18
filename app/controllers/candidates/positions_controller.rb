class Candidates::PositionsController < ApplicationController
  def update
    candidate = Candidate.find_by(id: params[:candidate_id])
    return render json: status_404, status: 404 if candidate.blank?
    return render json: status_400, status: 400 if candidate_params.blank?

    candidate.update(candidate_params)
    render json: CandidateBlueprint.render(candidate, view: :normal)
  end

  private
  
  def candidate_params
    params.fetch(:candidate, {}).permit(
      :recruitment_selection_id,
      :list_position,
    )
  end
end
