class MediaController < ApplicationController
  def index
    # TODO: Pagingについて考える
    media = Medium.all
    render json: MediumBlueprint.render(media, view: :normal)
  end

  def create
    medium = Medium.new(medium_params)
    if medium.save
      render json: MediumBlueprint.render(medium, view: :normal)
    else
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  def update
    medium = Medium.find(params[:id])
    if medium.update(medium_params)
      render json: MediumBlueprint.render(medium, view: :normal)
    else
      render json: { status: 400, message: '入力エラーです' }, status: 400
    end
  end

  private

  def medium_params
    params.require(:medium).permit(
      :name,
      :category, 
    )
  end
end
