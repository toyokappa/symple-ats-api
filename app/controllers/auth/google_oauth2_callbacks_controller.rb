class Auth::GoogleOauth2CallbacksController < ApplicationController
  skip_before_action :authenticate_recruiter!

  def create
    auth = request.env['omniauth.auth']
    recruiter = Recruiter.find_by(email: auth.info.email)
    if recruiter
      recruiter.update(
        google_access_token: auth.credentials.token,
        google_refresh_token: auth.credentials.refresh_token,
      )
      render json: RecruiterBlueprint.render(recruiter, view: :normal)
    else
      render json: status_400, status: 400
    end
  end
end
