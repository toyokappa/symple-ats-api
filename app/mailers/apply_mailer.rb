class ApplyMailer < ApplicationMailer
  def inform_candidate
    @organization = params[:organization]
    recruiters = @organization.recruiters.includes(:organization_recruiters).where(organization_recruiters: { role: :admin })
    emails = recruiters.uniq.pluck(:email)
    @candidate = params[:candidate]
    mail(to: emails, cc: @candidate.agent_email, subject: '【TheATS】新たに候補者の紹介がありました')
  end
end
