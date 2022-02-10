class RecruiterInvitationMailer < ApplicationMailer
  def invite_recruiter
    @invitation = params[:invitation]
    @url_base = "http://localhost:3000/#{@invitation.organization.unique_id}/recruiter_invitations/"
    mail(to: @invitation.email, subject: '【TheATS】新しい組織に招待されました')
  end
end
