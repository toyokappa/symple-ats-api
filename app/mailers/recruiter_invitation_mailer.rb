class RecruiterInvitationMailer < ActionMailer::Base
  default from: 'no-reply@symple.com'

  def invite_recruiter
    @invitation = params[:invitation]
    @url_base = 'http://localhost:3000/recruiter_invitations?token='
    mail(to: @invitation.email, subject: '【TheATS】新しい組織に招待されました')
  end
end
