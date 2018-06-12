# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'webmock/minitest'
require 'simplecov'

SimpleCov.start # Generate SimpleCov report during local testing

require 'europeana/fashion_redirects'
