class Auth::GoogleOauth2CallbacksController < ApplicationController
  def create
    res = GoogleOauth2ApiClient.new.convert_to_access_token(params[:code])
    credentials = JSON.parse(res.body)
    current_recruiter.update(
      google_access_token: credentials['access_token'],
      google_refresh_token: credentials['refresh_token'],
    )
    render status: 200
  end
end
