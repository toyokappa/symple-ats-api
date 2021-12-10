class PositionsController < ApplicationController
  def index
    # TODO: Pagingについて考える
    positions = Position.all
    render json: PositionBlueprint.render(positions, view: :normal)
  end

  def create
    position = Position.new(position_params)
    if position.save
      render json: PositionBlueprint.render(position, view: :normal)
    else
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  def update
    position = Position.find(params[:id])
    if position.update(position_params)
      render json: PositionBlueprint.render(position, view: :normal)
    else
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  private

  def position_params
    params.require(:position).permit(
      :internal_name,
      :external_name, 
      :status,
    )
  end
end
