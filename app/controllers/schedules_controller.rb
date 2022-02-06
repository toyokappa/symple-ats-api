class SchedulesController < ApplicationController
  skip_before_action :authenticate_recruiter!

  def index
    # TODO: ここのロジックも見直す
    recruiter = Recruiter.first
    render json: RecruiterBlueprint.render(recruiter, view: :only_schedules)
  end

  def create
    recruiter = Recruiter.first
    recruiter.create_event(event_params)
    # 日程調整完了の旨のメールを面接官、候補者の両者へ送信する
  end

  private

  def event_params
    params.require(:event).permit(:summary, :start, :end, :email)
  end
end
