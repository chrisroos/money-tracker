# encoding: utf-8

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def in_demo_mode(&block)
    ENV['DEMO_MODE'] = 'true'
    yield
  ensure
    ENV.delete('DEMO_MODE')
  end
end

require 'mocha/setup'