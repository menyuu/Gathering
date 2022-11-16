require "test_helper"

class EndUser::ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get end_user_chats_show_url
    assert_response :success
  end
end
