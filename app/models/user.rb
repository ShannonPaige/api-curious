class User < ActiveRecord::Base
  def self.find_or_create_from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.profile_image_url  = auth_info.extra.raw_info.profile_image_url
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["API"]
      config.consumer_secret     = ENV["API_SECRET"]
      config.access_token        = oauth_token
      config.access_token_secret = oauth_token_secret
    end
  end

  def twitter_user
    self.twitter.user
  end

  def number_of_tweets
    twitter_user.tweets_count
  end

  def followers
    twitter_user.followers_count
  end

  def following
    twitter_user.friends_count
  end

  def tweet_feed
    self.twitter.home_timeline.each do |tweet|
      tweet.tweet_details
    end
  end

  def tweet_details
    tweet.user.name
    tweet.user.screen_name
    tweet.text
    tweet.favorite_count
    tweet.retweet_count
  end

end
