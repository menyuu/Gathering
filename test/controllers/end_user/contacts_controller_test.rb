require "test_helper"

class EndUser::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get end_user_contacts_new_url
    assert_response :success
  end

  test "should get create" do
    get end_user_contacts_create_url
    assert_response :success
  end
end
