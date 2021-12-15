class Candidates::PositionsController < ApplicationController
  def update
    candidate = Candidate.find_by(id: params[:candidate_id])
    return render status: 404 if candidate.blank?

    # 選考履歴が必要な分作成する
    params[:require_selection_ids]&.each do |selection_id|
      candidate.recruitment_histories.find_or_initialize_by(recruitment_selection_id: selection_id)
    end

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
