class CandidatesController < ApplicationController
  def create
    candidate = Candidate.new(candidate_params)

    # 選考履歴が必要な分作成する
    params[:require_selection_ids]&.each do |selection_id|
      candidate.recruitment_histories.find_or_initialize_by(recruitment_selection_id: selection_id)
    end

    if candidate.save
      render json: CandidateBlueprint.render(candidate, view: :normal)
    else
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  def update
    candidate = Candidate.find(params[:id])
    if candidate.update(candidate_params)
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
