class MediaController < ApplicationController
  def index
    # TODO: Pagingについて考える
    media = Medium.all
    render json: MediumBlueprint.render(media, view: :normal)
  end

  def create
    return render json: status_400, status: 400 if medium_params.blank?

    medium = Medium.new(medium_params)
    if medium.save
      render json: MediumBlueprint.render(medium, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def update
    medium = Medium.find_by(id: params[:id])
    return render json: status_404, status: 404 if medium.blank?
    return render json: status_400, status: 400 if medium_params.blank?

    if medium.update(medium_params)
      render json: MediumBlueprint.render(medium, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def medium_params
    params.fetch(:medium, {}).permit(
      :name,
      :category, 
    )
  end
end
