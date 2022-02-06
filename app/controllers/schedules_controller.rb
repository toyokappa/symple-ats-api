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
    start_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: Time.zone.parse(event_params[:start]).xmlschema,
    )
    end_time = Google::Apis::CalendarV3::EventDateTime.new(
      date_time: Time.zone.parse(event_params[:end]).xmlschema,
    )

    conference_solution_key = Google::Apis::CalendarV3::ConferenceSolutionKey.new(
      type: 'hangoutsMeet',
    )
    conference_request = Google::Apis::CalendarV3::CreateConferenceRequest.new(
      request_id: SecureRandom.alphanumeric(10),
      conference_solution_key: conference_solution_key,
    )
    conference_data = Google::Apis::CalendarV3::ConferenceData.new(
      create_request: conference_request,
    )

    recruiters = @history.recruiters
    attendees = recruiters.map do |recruiter|
      Google::Apis::CalendarV3::EventAttendee.new(
        email: recruiter.google_oauth2_email,
      )
    end

    new_event = Google::Apis::CalendarV3::Event.new(
      summary: event_params[:summary],
      start: start_time,
      end: end_time,
      conference_data: conference_data,
      attendees: attendees,
    )

    recruiters.first.create_event(new_event)
    @history.update(selected_at: event_params[:start])
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
