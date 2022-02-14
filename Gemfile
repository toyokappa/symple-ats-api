source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'blueprinter'
gem 'active_storage_validations'

gem 'rack-cors'

gem 'devise_token_auth'
gem 'acts_as_list'
gem 'omniauth-google-oauth2'
gem 'faraday'
gem 'faraday_middleware'
gem 'google-apis-calendar_v3'
gem 'jwt'

group :development, :test do
  gem 'seed-fu'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "rspec_junit_formatter"
  gem "factory_bot_rails"
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'annotate'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
