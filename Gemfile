source "https://rubygems.org"
ruby "2.2.2"

gem "rails", "4.1.7"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 1.2"
gem "microformats2"
gem 'g5_updatable', '~> 0.5.1'

group :assets do
  gem "sass-rails", "~> 4.0.0"
  gem "bourbon", "~> 3.1.8"
  gem "uglifier", ">= 1.3.0"
  gem "coffee-rails", "~> 4.0.0"
end

group :development, :test do
  gem "dotenv-rails", "~> 0.9.0"
  gem "sqlite3"
  gem "rspec-rails", "~> 2.14.0"
  gem "capybara"
  gem "poltergeist"
  gem "database_cleaner", "< 1.1.0"
  gem "foreman"
  gem "fabrication"
  gem "faker"
  gem "pry"
end

group :doc do
  gem "sdoc", require: false
end

group :production do
  gem "rails_12factor"
  gem "pg"
  gem "newrelic_rpm"
  gem "honeybadger"
  gem "lograge"
  gem "unicorn"
end
