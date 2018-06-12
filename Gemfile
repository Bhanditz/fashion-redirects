# frozen_string_literal: true
source 'https://rubygems.org'

gem 'europeana-api', github: 'europeana/europeana-api-client-ruby', branch: 'develop'
gem 'newrelic_rpm'
gem 'pg'
gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'

group :production do
  gem 'rails_12factor'
end

group :production, :development do
  gem 'puma'
end

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', '0.54', require: false
end

group :development do
  gem 'foreman'
end

group :test do
  gem 'minitest'
  gem 'rack-test', require: 'rack/test'
  gem 'simplecov', require: false
  gem 'webmock'
end
