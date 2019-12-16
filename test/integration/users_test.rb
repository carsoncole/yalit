require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test "signup process" do
    get sign_up_path
    assert_response :success

    post users_path, params: { user: { email: "john@example.com", password: "password"} }
    assert_select "h1", "Sign up"
    assert_select "li", "Email is not an allowable email domain"

    post users_path, params: { user: { email: "john@grade.us", password: "password"} }
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Projects"
  end

  test "creating a project" do
    user = create(:user)
    get projects_path(as: user)
    assert_response :success
  end
end
