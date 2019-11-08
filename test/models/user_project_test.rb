require "test_helper"

class UserProjectTest < ActiveSupport::TestCase
  test "changing owner role is not possible if only user" do
    user = create(:user)
    user_projects = user.user_projects
    project = user.user_projects.last
    assert_equal user_projects.count, 1
    assert_equal user_projects.last.role, 'owner'
    project.role = 'admin'
    assert_not project.valid?
  end
end
