# frozen_string_literal: true
require 'test_helper'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Europeana::FashionRedirects::App
  end
end
