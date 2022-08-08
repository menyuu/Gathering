require "test_helper"

class EndUser::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_genres_index_url
    assert_response :success
  end
end
