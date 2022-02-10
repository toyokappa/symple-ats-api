class AppliesController < ApplicationController
  before_action :find_organization

  def show
    channel = @organization.channels.find_by(apply_token: params[:token])
    return render json: status_404, status: 404 if channel.blank?

    render json: ChannelBlueprint.render(channel, view: :normal)
  end

  def create
    # TODO: firstでいいかは謎
    project = @organization.recruitment_projects.first
    selection = project.recruitment_selections.find_by(selection_type: :document)
    candidate = selection.candidates.build(candidate_params)
    if candidate.save
      ApplyMailer.with(organization: @organization, candidate: candidate).inform_candidate.deliver_now
    else
      return render json: status_400, status: 400
    end
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end

  def candidate_params
    params.fetch(:candidate, {}).permit(
      :name,
      :position_id,
      :channel_id,
      :description,
      :agent_name,
      :agent_email,
      resumes: [],
    )
  end
end
