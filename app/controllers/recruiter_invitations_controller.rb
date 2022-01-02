class RecruiterInvitationsController < ApplicationController
  skip_before_action :authenticate_recruiter!, only: %i[show]
  before_action :find_organization

  def index
    # TODO: Pagingについて考える
    invitations = @organization.recruiter_invitations.all
    render json: RecruiterInvitationBlueprint.render(invitations, view: :normal)
  end

  def show
    invitation = @organization.recruiter_invitations.find_by(token: params[:token])
    return render json: status_404, status: 404 if invitation.blank?

    recruiter = Recruiter.find_by(email: invitation.email)
    render json: RecruiterInvitationBlueprint.render(invitation, view: :normal, root: :invitation, meta: { recruiterExists: recruiter.present? })
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
