require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :redirect
  end

  test "no_found path, should be public" do
    get not_found_url
    assert_response :success
  end
end
