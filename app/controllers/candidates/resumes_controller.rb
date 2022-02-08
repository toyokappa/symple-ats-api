class Candidates::ResumesController < ApplicationController
  before_action :find_candidate

  def create
    return render json: status_400, status: 400 if resume_params.blank?

    if @candidate.resumes.attach(resume_params[:files])
      render json: CandidateBlueprint.render(@candidate, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def destroy
    resume = @candidate.resumes.find_by(id: params[:id])
    resume.destroy
    render json: CandidateBlueprint.render(@candidate, view: :normal)
  end

  private

  def find_candidate
    @candidate = Candidate.find_by(id: params[:candidate_id])
    return render json: status_404, status: 404 if @candidate.blank?
  end

  def resume_params
    params.fetch(:resume, {}).permit(
      files: []
    )
  end
end
