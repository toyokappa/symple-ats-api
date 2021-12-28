class RecruiterInvitationsController < ApplicationController
  before_action :find_organization

  def index
    # TODO: Pagingについて考える
    invitations = @organization.recruiter_invitations.all
    render json: RecruiterInvitationBlueprint.render(invitations, view: :normal)
  end

  def show
    invitation = @organization.recruiter_invitations.find_by(token: params[:token])
    return render json: status_404, status: 404 if invitation.blank?

    if current_recruiter.email == invitation.email
      ActiveRecord::Base.transaction do
        @organization.organization_recruiters.create!(
          recruiter: current_recruiter,
          role: invitation.role
        )
        invitation.destroy!
      end
      render json: RecruiterBlueprint.render(current_recruiter, view: :with_organization, current_org: @organization)
    else
      render json: status_401, status: 401
    end
  end

  def create
    invitation = @organization.recruiter_invitations.build(invitation_params)
    if invitation.save
      RecruiterInvitationMailer.with(invitation: invitation).invite_recruiter.deliver_later
      render json: RecruiterInvitationBlueprint.render(invitation, view: :normal)
    else
      render json: status_400, status: 400
    end
  end

  private

  def invitation_params
    params.fetch(:invitation, {}).permit(:email, :role)
  end

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end
end
