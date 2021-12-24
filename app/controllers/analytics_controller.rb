class AnalyticsController < ApplicationController
  def index
    project = RecruitmentProject.first # プロジェクトの特定方法は別途考える
    render json: project.chart_data.as_json
  end
end
