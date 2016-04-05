require "test_helper"

class CachingClientTest < ActiveSupport::TestCase
  test "CachingClient redirects missing methods [all] to twitter client" do
    mock_client = Minitest::Mock.new
    mock_client.expect(:any_random_method, "no error raised")
    client = CachingClient.allocate
    client.instance_variable_set("@client", mock_client)

    # assert_equal CachingClient.any_random_method, "no error raised"
    assert_equal "no error raised", client.any_random_method
  end

end
