require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def auth_info
    OmniAuth::AuthHash.new({
                'uid' => '12345',
                'extra' => { 'raw_info' => { 'name' => 'Shannon', 'screen_name' => 'spaige', 'profile_image_url' => '' }},
                'credentials' => {'token' => '67', 'secret' => '89' }
            })
  end

  test "a user can be found or created" do
    User.find_or_create_from_omniauth(auth_info)
    user = User.last

    assert_equal '12345',   user.uid
    assert_equal 'Shannon', user.name
    assert_equal 'spaige',  user.screen_name
    assert_equal '',        user.profile_image_url
    assert_equal '67',      user.oauth_token
    assert_equal '89',      user.oauth_token_secret
  end
end
