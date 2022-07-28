require "test_helper"

class EndUser::GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_games_index_url
    assert_response :success
  end
end
