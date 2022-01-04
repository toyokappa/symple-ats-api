class GoogleOauth2ApiClient
  API_HOST = 'https://oauth2.googleapis.com'
  CLIENT_ID = ENV['GOOGLE_CLIENT_ID']
  CLIENT_SECRET = ENV['GOOGLE_CLIENT_SECRET']
  REDIRECT_URI = ENV['GOOGLE_OAUTH2_REDIRECT_URI']

  def convert_to_access_token(code)
    Faraday.post("#{API_HOST}/token",
             client_id: CLIENT_ID,
             client_secret: CLIENT_SECRET,
             code: code,
             grant_type: 'authorization_code',
             redirect_uri: REDIRECT_URI,
            )
  end
end
