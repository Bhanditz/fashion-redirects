# frozen_string_literal: true
$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'bundler/setup'
ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])

Dotenv.load if defined?(Dotenv)

ENV['DATABASE_URL'] = ENV['POSTGRES_URI'] unless ENV['POSTGRES_URI'].blank?

require 'europeana/fashion_redirects'
