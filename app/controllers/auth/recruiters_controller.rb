class Auth::RecruitersController < ApplicationController
  def show
    if params[:organization_id]
      organization = current_recruiter.organizations.find_by(unique_id: params[:organization_id])
    else 
      organization = current_recruiter.organizations.first
    end

    return render json: status_404, status: 404 if organization.blank?

    render json: RecruiterBlueprint.render(current_recruiter, view: :with_organization, selected_organization: organization)
  end
end
