class CandidatesController < ApplicationController
  def create
    return render json: status_400, status: 400 if candidate_params.blank?

    candidate = Candidate.new(candidate_params)

    if candidate.save
      render json: CandidateBlueprint.render(candidate, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def update
    candidate = Candidate.find_by(id: params[:id])
    return render json: status_404, status: 404 if candidate.blank?
    return render json: status_400, status: 400 if candidate_params.blank?

    if candidate.update(candidate_params)
      render json: CandidateBlueprint.render(candidate, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def candidate_params
    params.fetch(:candidate, {}).permit(
      :name,
      :recruitment_selection_id,
      :recruiter_id,
      :channel_id,
      :position_id,
      resumes: [],
    )
  end
end
