class SchedulesController < ApplicationController
  skip_before_action :authenticate_recruiter!

  def index
    recruiter = Recruiter.first
    render json: RecruiterBlueprint.render(recruiter, view: :only_schedules)
  end
end
