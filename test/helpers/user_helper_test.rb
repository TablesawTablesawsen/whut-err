require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  test "returns text of tweet if it is not retweeting and has no mentions" do
    tweet = Minitest::Mock.new
    tweet.expect(:retweet?, nil)
    tweet.expect(:full_text, "Text of tweet")
    tweet.expect(:user_mentions?, nil)

    assert_equal "Text of tweet", text_with_user_mentions(tweet)
  end

  test "returns text of retweeted tweet if it exists" do
    retweet = Minitest::Mock.new
    retweet.expect(:retweet?, nil)
    retweet.expect(:full_text, "Text of retweet")
    retweet.expect(:user_mentions?, nil)
    tweet = Minitest::Mock.new
    tweet.expect(:retweet?, true)
    tweet.expect(:retweeted_status, retweet)

    assert_equal "Text of retweet", text_with_user_mentions(tweet)
  end

  test "adds links to tweet if it has user mentions" do
    tweet = mock_tweet_with_user_mentions

    result = text_with_user_mentions(tweet)

    expected = "Two things. And I call them <a title=\"Thing One\" "\
               "data-toggle=\"popover\" data-content=\"11 tweets | 111 "\
               "followers\" data-trigger=\"focus hover\" "\
               "href=\"/users/thing1\">@Thing1</a> and <a title=\"Thing Two\" "\
               "data-toggle=\"popover\" data-content=\"22 tweets | 222 "\
               "followers\" data-trigger=\"focus hover\" "\
               "href=\"/users/thing2\">@Thing2</a>."
    assert_equal expected, result
  end

  private

  def mock_tweet_with_user_mentions
    user1 = Minitest::Mock.new
    user1.expect(:tweets_count, 11)
    user1.expect(:followers_count, 111)

    user2 = Minitest::Mock.new
    user2.expect(:tweets_count, 22)
    user2.expect(:followers_count, 222)

    @client = Minitest::Mock.new
    @client.expect(:user, user2, ["thing2"])
    @client.expect(:user, user1, ["thing1"])

    mention1 = Minitest::Mock.new
    2.times {mention1.expect(:screen_name, "thing1")}
    mention1.expect(:name, "Thing One")
    2.times {mention1.expect(:indices, [28, 35])}

    mention2 = Minitest::Mock.new
    2.times {mention2.expect(:screen_name, "thing2")}
    mention2.expect(:name, "Thing Two")
    2.times {mention2.expect(:indices, [40, 47])}

    tweet = Minitest::Mock.new
    tweet.expect(:retweet?, nil)
    tweet.expect(:full_text, "Two things. And I call them @Thing1 and @Thing2.")
    tweet.expect(:user_mentions?, true)
    tweet.expect(:user_mentions, [mention1, mention2])
    tweet
  end

end
