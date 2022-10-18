require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user can be created" do
    assert create(:user)
  end

  test "identify owner/user of a project" do
    user = create(:user)
    project = user.projects.create(attributes_for(:project))
    assert user.owner?(project)
    assert_not user.user?(project)
    assert user.owner_or_admin?(project)
  end

  test "user-created projects don't remain after destroying user if they are owner" do
    user = create(:user)
    project = user.projects.create(attributes_for(:project))
    assert_equal project.user_projects.where(user: user).first.role, "owner"
    assert user.destroy
    assert_not Project.find_by(id: project.id)
  end
end
