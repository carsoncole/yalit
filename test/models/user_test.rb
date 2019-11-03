require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user can be created" do
    assert create(:user)
  end
end
