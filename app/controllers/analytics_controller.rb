class AnalyticsController < ApplicationController
  before_action :find_organization

  def index
    project = @organization.recruitment_projects.first # プロジェクトの特定方法は別途考える
    render json: project.chart_data.as_json
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end
end
