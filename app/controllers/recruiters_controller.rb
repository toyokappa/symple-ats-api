class RecruitersController < ApplicationController
  before_action :find_organization

  def index
    # TODO: Pagingについて考える
    recruiters = @organization.recruiters.all
    render json: RecruiterBlueprint.render(recruiters, view: :normal)
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end
end
