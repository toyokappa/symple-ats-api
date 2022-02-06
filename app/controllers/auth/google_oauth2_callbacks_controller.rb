class Auth::GoogleOauth2CallbacksController < ApplicationController
  def create
    res = GoogleOauth2ApiClient.new.convert_to_access_token(params[:code])
    credentials = JSON.parse(res.body)
    user_info = JWT.decode(credentials['id_token'], nil, false)
    current_recruiter.update(
      google_access_token: credentials['access_token'],
      google_refresh_token: credentials['refresh_token'],
      google_oauth2_email: user_info[0]['email'],
    )
    render status: 200
  end
end
