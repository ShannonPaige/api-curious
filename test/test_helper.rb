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

  def stub_twitter_request
    stub_request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json").
      with(:headers => {'Accept'            =>'application/json',
                        'Accept-Encoding'   =>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                        'Authorization'     =>'OAuth oauth_consumer_key="kj8l5Uc1nhsYiqifw0xEaK61f",
                                              oauth_nonce="db35823cc0b34d420506b82658d0ac58",
                                              oauth_signature="AF1Ef562CpoAWMrczJfOJr1dLKY%3D",
                                              oauth_signature_method="HMAC-SHA1",
                                              oauth_timestamp="1450322070", 
                                              oauth_token="61068111-XFa2JjwZJzfPBUWXLdElj8iZ2D7i1YgWRo5KMgjXP",
                                              oauth_version="1.0"',
                        'User-Agent'=>'TwitterRubyGem/5.15.0'}).
      to_return(:status => 200, :body => "", :headers => {})
  end
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
