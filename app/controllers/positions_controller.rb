class PositionsController < ApplicationController
  def index
    # TODO: Pagingについて考える
    positions = Position.all
    render json: PositionBlueprint.render(positions, view: :normal)
  end

  def create
    return render json: status_400, status: 400 if position_params.blank?

    position = Position.new(position_params)
    if position.save
      render json: PositionBlueprint.render(position, view: :normal)
    else
      render json: status_400, status: 400
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  def update
    position = Position.find_by(id: params[:id])
    return render json: status_404, status: 404 if position.blank?
    return render json: status_400, status: 400 if position_params.blank?

    if position.update(position_params)
      render json: PositionBlueprint.render(position, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def position_params
    params.fetch(:position, {}).permit(
      :internal_name,
      :external_name, 
      :status,
    )
  end
end
