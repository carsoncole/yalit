require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test "can see the welcome page" do
    get "/"
    assert_select "h1", "Get started building API-hosted documentation to support customer access to your application!"
  end

  test "entering email on home page" do
    get "/"
    get noname_path, params: {  email: "john@example.com"  }
    assert_select "h1", "Sign up"
    assert_select "a", "Sign in"
    assert_response :success
  end
end
