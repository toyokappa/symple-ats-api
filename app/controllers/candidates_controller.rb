class CandidatesController < ApplicationController
  def create
    candidate = Candidate.new(candidate_params)
    if candidate.save
      render json: CandidateBlueprint.render(candidate, view: :normal)
    else
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(
      :name,
      :recruitment_selection_id,
      :recruiter_id,
      :medium_id,
      :position_id,
    )
  end
end
