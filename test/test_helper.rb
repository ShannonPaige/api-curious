ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "mocha/mini_test"
require "minitest/pride"
require "simplecov"
require 'webmock'
require 'vcr'

SimpleCov.start "rails"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
  end

  # stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
  #   to_return(:status => 200, :body => "", :headers => {})
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Shannon",
          screen_name: "spaige",
        }
      },
      credentials: {
        token: "pizza",
        secret: "secretpizza"
      }
    })
  end

  def teardown
    reset_session!
  end

end

DatabaseCleaner.strategy = :transaction

class Minitest::Spec
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
