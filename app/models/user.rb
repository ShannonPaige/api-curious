class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.profile_image_url  = auth_info.extra.raw_info.profile_image_url
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end

  def self.twitter
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["API"]
      config.consumer_secret     = ENV["API_SECRET"]
      config.access_token        = current_user.oauth_token  #this might be wrong, maybe config.oauth_token
      config.access_token_secret = current_user.oauth_token_secret
    end
  end
end
