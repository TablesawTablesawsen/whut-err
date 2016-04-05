require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @test_name = "test_user"
    @client = mock_client(@test_name)
  end

  test "can get show" do
    CachingClient.stub :new, @client do
      get :show, id: @test_name
    end

    assert_response :success
  end

  test "can search for user" do
    CachingClient.stub :new, @client do
      get :show, id: "other_user", screenname: @test_name
    end

    assert_redirected_to controller: "users", action: "show", id: @test_name
  end

  private

  def mock_client(test_name)
    client = Minitest::Mock.new
    client.expect(:user, mock_user, [test_name])
    client.expect(:user_timeline, [mock_tweet], [test_name])
    client
  end

  def mock_tweet
    tweet = Minitest::Mock.new
    2.times { tweet.expect(:retweet?, nil) }
    tweet.expect(:created_at, 1.hour.ago)
    tweet.expect(:full_text, "Text of tweet")
    tweet.expect(:user_mentions?, nil)
    tweet
  end

  def mock_user
    user = Minitest::Mock.new
    user.expect(:profile_image_uri, "", [:original])
    2.times { user.expect(:name, "User Name") }
    user
  end

end
