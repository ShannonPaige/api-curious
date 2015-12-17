require './test/test_helper'

class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :twitter_service

  def setup
    user = create_user
    @twitter_service = TwitterService.new(user)
  end

  def create_user
    User.new(id: 1,
            name: "ShannonTest",
            screen_name: "shannontest",
            uid: "61068111",
            oauth_token: ENV["OATH"],
            oauth_token_secret: ENV["OATH_SECRET"],
            profile_image_url: "http://pbs.twimg.com/profile_images/660831824189370368/I3QKiPah_normal.jpg")
  end

  test "#get_tweets_count" do
    VCR.use_cassette("twitter_service#get_tweets_count") do
      twitter_service.get_tweets_count

      assert_equal 60, twitter_service.get_tweets_count
    end
  end

  test "#get_followers_count" do
    VCR.use_cassette("twitter_service#get_followers_count") do
      twitter_service.get_followers_count

      assert_equal 111, twitter_service.get_followers_count
    end
  end

  test "#get_following_count" do
    VCR.use_cassette("twitter_service#get_following_count") do
      twitter_service.get_following_count

      assert_equal 79, twitter_service.get_following_count
    end
  end

  test "#get_timeline" do
    VCR.use_cassette("twitter_service#get_timeline") do
      tweets = twitter_service.get_timeline

      assert_equal 20, twitter_service.get_timeline.count
    end
  end

  test "#favorite_it" do
    VCR.use_cassette("twitter_service#favorite_it") do
      tweets = twitter_service.favorite_it(1)

      assert_equal [], twitter_service.favorite_it(1)
    end
  end

  test "#tweet_it" do
    VCR.use_cassette("twitter_service#tweet_it") do
      tweets = twitter_service.tweet_it("Tweet Test")

      assert_equal "#<Twitter::Tweet id=677322827691724801>", twitter_service.tweet_it("Tweet Test")
    end
  end

end
