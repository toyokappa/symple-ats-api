class PositionsController < ApplicationController
  before_action :find_organization

  def index
    # TODO: Pagingについて考える
    positions = @organization.positions.all
    render json: PositionBlueprint.render(positions, view: :normal)
  end

  def create
    return render json: status_400, status: 400 if position_params.blank?

    position = @organization.positions.build(position_params)
    if position.save
      render json: PositionBlueprint.render(position, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def update
    position = @organization.positions.find_by(id: params[:id])
    return render json: status_404, status: 404 if position.blank?
    return render json: status_400, status: 400 if position_params.blank?

    if position.update(position_params)
      render json: PositionBlueprint.render(position, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end

  def position_params
    params.fetch(:position, {}).permit(
      :internal_name,
      :external_name, 
      :status,
    )
  end
end
