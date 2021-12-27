class ChannelsController < ApplicationController
  before_action :find_organization

  def index
    # TODO: Pagingについて考える
    channnels = @organization.channels.all
    render json: ChannelBlueprint.render(channnels, view: :normal)
  end

  def create
    return render json: status_400, status: 400 if channel_params.blank?

    channel = @organization.channels.build(channel_params)
    if channel.save
      render json: ChannelBlueprint.render(channel, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  def update
    channel = @organization.channels.find_by(id: params[:id])
    return render json: status_404, status: 404 if channel.blank?
    return render json: status_400, status: 400 if channel_params.blank?

    if channel.update(channel_params)
      render json: ChannelBlueprint.render(channel, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end

  def channel_params
    params.fetch(:channel, {}).permit(
      :name,
      :category, 
    )
  end
end
