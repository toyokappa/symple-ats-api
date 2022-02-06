class SchedulesController < ApplicationController
  skip_before_action :authenticate_recruiter!
  before_action :find_history

  def show
    recruiters = @history.recruiters
    busy_times = recruiters.map(&:get_busy_times).flatten.uniq
    vacant_times = ScheduleCoordinator.new.exchange_busy_times_to_vacent_times(busy_times)
    render json: vacant_times.as_json
  end

  def update
    recruiters = @history.recruiters
    recruiters.each {|recruiter| recruiter.create_event(event_params) }
    # 日程調整完了の旨のメールを面接官、候補者の両者へ送信する
  end

  private

  def find_history
    @history = RecruitmentHistory.find_by(auto_scheduling_token: params[:token])
    return render json: status_404, status: 404 if @history.blank?
  end

  def event_params
    params.require(:event).permit(:summary, :start, :end, :email)
  end
end
