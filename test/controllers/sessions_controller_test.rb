require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get sign in" do
    get sign_in_url
    assert_response :success
  end

  test "should be able to access site as user" do
    user = create(:user)
    get root_url(as: user)
    assert_response :success
  end
end
