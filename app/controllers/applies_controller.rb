class AppliesController < ApplicationController
  before_action :find_organization

  def show
    channel = @organization.channels.find_by(apply_token: params[:token])
    return render json: status_404, status: 404 if channel.blank?

    render json: ChannelBlueprint.render(channel, view: :normal)
  end

  def create
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end
end
