require "test_helper"

class EndUser::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get end_user_home_top_url
    assert_response :success
  end
end
