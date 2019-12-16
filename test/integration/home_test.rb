require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test "can see the welcome page" do
    get "/"
    assert_select "h1", "Get started building API-hosted documentation to support customer access to your application!"
  end
end
