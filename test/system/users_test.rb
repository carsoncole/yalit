require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    sign_in_as(users(:standard))
  end

  test "projects index page after signing in" do
    assert_selector "h1", text: "Projects"
  end
end
