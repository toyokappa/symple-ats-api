class RecruitmentSelectionsController < ApplicationController
  before_action :find_organization

  def index
    # プロジェクトを追加できることを想定しての念の為の実装
    project = @organization.recruitment_projects.first
    selections = project.recruitment_selections.all.includes(candidates: [:recruiter, :channel, :position, :recruitment_histories])
    render json: RecruitmentSelectionBlueprint.render(selections, view: :normal)
  end

  private

  def find_organization
    @organization = Organization.find_by(unique_id: params[:organization_id])
    return render json: status_404, status: 404 if @organization.blank?
  end
end
