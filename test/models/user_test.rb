require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user can be created" do
    assert create(:user)
  end

  test "user-created projects remain after destroying user" do
    user = create(:user)
    project = create(:project)
    project.user_projects.build(user: user)

    user.destroy
    assert Project.find(project.id)
    asset_not User.find_by(id: user.id)
  end
end

