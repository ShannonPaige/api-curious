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

  def stub_tweet_request

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
    twitter_service.stubs(:favorite).returns(Twitter::Tweet.new(id: 123))
    VCR.use_cassette("twitter_service#favorite_it") do

      assert_equal Twitter::Tweet, twitter_service.favorite(1).class
      assert_equal Array, twitter_service.favorite_it(1).class
    end
  end

  test "#tweet_it" do
    twitter_service.stubs(:update).returns(Twitter::Tweet.new(id: 123))
    VCR.use_cassette("twitter_service#tweet_it") do

      assert_equal Twitter::Tweet, twitter_service.update("Tweet Test").class
      assert_equal Twitter::Tweet, twitter_service.tweet_it("Tweet Test").class
    end
  end

  test "#retweet_it" do
    twitter_service.stubs(:retweet).returns(Twitter::Tweet.new(id: 123))
    VCR.use_cassette("twitter_service#retweet_it") do

      assert_equal Twitter::Tweet, twitter_service.retweet("Tweet Test").class
      assert_equal Array, twitter_service.retweet_it("Tweet Test").class
    end
  end

  test "#unfollow_this_guy" do
    twitter_service.stubs(:unfollow).returns(Array.new)
    VCR.use_cassette("twitter_service#unfollow_this_guy") do

      assert_equal Array, twitter_service.unfollow(1133971).class
    end
  end

end
