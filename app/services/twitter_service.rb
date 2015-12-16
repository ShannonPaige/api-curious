class TwitterService
  attr_reader :connection

  def initialize(user)
    @user = user
    @connection ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["API"]
      config.consumer_secret     = ENV["API_SECRET"]
      config.access_token        = @user.oauth_token
      config.access_token_secret = @user.oauth_token_secret
    end
  end

  def twitter_user
    @twitter_user ||= connection.user
  end

  def get_tweets_count
    twitter_user.tweets_count
  end

  def get_followers_count
    twitter_user.followers_count
  end

  def get_following_count
    twitter_user.friends_count
  end

  def favorite_it(tweet_id)
    connection.favorite(tweet_id.to_i)
  end

  def get_timeline
    connection.home_timeline
  end
end
