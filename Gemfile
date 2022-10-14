source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.4"

gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "pg"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false

# Use SCSS for stylesheets
gem "sassc-rails", "~> 2.1"


# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"
# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variant
# gem "image_processing", "~> 1.2"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "rubocop", "~> 0.76.0", require: false
  gem "rubocop-rails_config"
  gem "faker"
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

gem "haml-rails"
gem "bootstrap", "~> 4.3.1"
gem "jquery-rails"
gem "kramdown"
gem "font-awesome-rails"
gem "clearance"
gem 'platform-api'
gem 'json'
gem 'rack-cors'
gem 'httparty'
gem 'simplecov', require: false, group: :test
gem 'evil_icons'
