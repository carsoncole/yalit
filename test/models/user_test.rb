require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user can be created" do
    assert create(:user)
  end

  test "non-Martech domains can not register" do
    user = build(:user, email: "john.doe@example.com")
    assert_not user.save, "Was able to create a new user with a non-Martech domain"
  end

  test "only Martech domains can register" do
    user = build(:user, email: "john.doe@grade.us")
    assert user.save, "Was not able to register a Martech domain email"
  end

  test "identify owner/user of a project" do
    user = create(:user)
    project = user.projects.create(attributes_for(:project))
    assert user.owner?(project)
    assert_not user.user?(project)
    assert user.owner_or_admin?(project)
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
