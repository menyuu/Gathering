require "test_helper"

class Admin::GroupChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_group_chats_index_url
    assert_response :success
  end
end
