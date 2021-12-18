class ChannelsController < ApplicationController
  def index
    # TODO: Pagingについて考える
    channnels = Channel.all
    render json: ChannelBlueprint.render(channnels, view: :normal)
  end

  def create
    return render json: status_400, status: 400 if channel_params.blank?

    channel = Channel.new(channel_params)
    if channel.save
      render json: ChannelBlueprint.render(channel, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def update
    channel = Channel.find_by(id: params[:id])
    return render json: status_404, status: 404 if channel.blank?
    return render json: status_400, status: 400 if channel_params.blank?

    if channel.update(channel_params)
      render json: ChannelBlueprint.render(channel, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def channel_params
    params.fetch(:channel, {}).permit(
      :name,
      :category, 
    )
  end
end
