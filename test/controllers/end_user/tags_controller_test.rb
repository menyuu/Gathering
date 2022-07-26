require "test_helper"

class EndUser::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_tags_index_url
    assert_response :success
  end

  test "should get show" do
    get end_user_tags_show_url
    assert_response :success
  end

  test "should get new" do
    get end_user_tags_new_url
    assert_response :success
  end

  test "should get edit" do
    get end_user_tags_edit_url
    assert_response :success
  end
end
