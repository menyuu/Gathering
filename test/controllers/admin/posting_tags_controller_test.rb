require "test_helper"

class Admin::PostingTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_posting_tags_index_url
    assert_response :success
  end
end
