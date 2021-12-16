class Candidates::PositionsController < ApplicationController
  def update
    candidate = Candidate.find_by(id: params[:candidate_id])
    return render status: 404 if candidate.blank?

    candidate.update(candidate_params)
    render json: CandidateBlueprint.render(candidate, view: :normal)
  end

  private
  
  def candidate_params
    params.require(:candidate).permit(
      :recruitment_selection_id,
      :list_position,
    )
  end
end
