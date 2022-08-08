require "test_helper"

class EndUser::GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_groups_index_url
    assert_response :success
  end

  test "should get show" do
    get end_user_groups_show_url
    assert_response :success
  end

  test "should get new" do
    get end_user_groups_new_url
    assert_response :success
  end

  test "should get edit" do
    get end_user_groups_edit_url
    assert_response :success
  end
end
