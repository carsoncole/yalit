require "test_helper"

class UserProjectTest < ActiveSupport::TestCase
  test "changing owner role is not possible if only user" do
    user = create(:user)
    project = create(:project)
    user_project = user.user_projects.create(project_id: project.id, user_id: user.id)
    user_projects = user.user_projects
    assert_equal user_projects.count, 1
    assert_equal user_project.role, 'owner'
    user_project.role = 'admin'
    assert_not user_project.valid?
  end

  test "role must be in list" do
    user = create(:user)
    project = create(:project)
    user_project = UserProject.create(user_id: user.id, project_id: project.id)
    assert_not user_project.update(role: "helper")
    assert user_project.update(role: "owner")
  end

  test "deleting a project if un-owned" do
    user = create(:user)
    project = create(:project)
    user_project = UserProject.create(user_id: user.id, project_id: project.id, role: "owner")
    assert_equal 1, user.projects.count
    assert_difference "Project.count", -1 do
      user.destroy
    end
  end
end
