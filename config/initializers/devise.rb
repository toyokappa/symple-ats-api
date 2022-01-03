Devise.setup do |config|
  config.mailer_sender = 'no-reply@symple.com'
  config.mailer = 'Recruiters::Mailer'
  config.confirm_within = 1.days
end
