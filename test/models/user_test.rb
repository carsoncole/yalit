require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user can be created" do
    assert create(:user)
  end


  # test "user-created projects don't remain after destroying user if they are owner" do
  #   user = create(:user)
  #   user_project = user.user_projects.last
  #   project = user.user_projects.last

  #   assert_equal user_project.role, "owner"

  #   assert user.destroy
  #   assert_not Project.find_by(id: project.id)
  # end
end
