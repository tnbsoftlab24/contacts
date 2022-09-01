source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'foreman'
gem 'telephone_number'
# Authentication & Authorizaton
gem 'devise'
gem 'jwt'
gem 'omniauth-facebook'
gem "omniauth", "~> 1.9.1"
gem 'pundit'
# gem "simple_token_authentication"

# Translation
gem 'devise-i18n'

# form
gem 'simple_form'
gem 'countries', require: 'countries/global'
gem 'country_select', '~> 4.0'
gem 'ransack'


# email template
gem 'inky-rb', require: 'inky'
# Stylesheet inlining for email
gem 'premailer-rails'


# Carriewave
gem "carrierwave"
gem "mini_magick"
gem "fog-aws"
gem "aws-sdk-s3", require: false


# SMS
# gem 'sendgrid-ruby'
gem 'twilio-ruby'
gem 'rack-cors'
gem 'telnyx'
gem 'vonage'

# Filter
gem 'pg_search'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
gem 'will_paginate-bootstrap-style'


 
# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.4.2', require: false
gem 'letsencrypt-rails-heroku', group: 'production'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'letter_opener', '~> 1.4.1'
  # gem 'faker'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "bugsnag", "~> 6.18"
