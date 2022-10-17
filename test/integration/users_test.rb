require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test "signup process" do
    get sign_up_path
    assert_response :success

    assert_select "h1", "Sign up"
    post users_path, params: { user: { email: Faker::Internet.email, password: Faker::Internet.password} }
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Projects"
  end

  test "sign-in page"  do
    user = create(:user)
    get sign_in_url
    assert_select "h1", "Sign in"

    post session_path, params: { session: { email: user.email, password: user.password } }
    assert_response :redirect
    follow_redirect!

    assert_select "h1", "Projects"
  end

  test "forgot password" do
    get sign_in_url
    assert_select "a", "Forgot password?"

    get new_password_path
    assert_response :success
  end

  test "creating a project" do
    user = create(:user)
    get projects_path(as: user)
    assert_response :success
  end
end
