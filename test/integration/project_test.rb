require 'test_helper'

class ProjectTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @project = @user.projects.create(title: "ACME Com")
    get root_path(as: @user)
  end

  test "list of all projects" do
    get projects_path(as: @user)
    assert :success
    assert_select "h1", "Projects"
  end

  test "editing the title of a project" do
    project = @user.projects.create(title: 'XYX API')

    get edit_project_path(project, as: @user)
    assert :success
    patch project_url(project.id, as: @user), params: { project: { title: "ACME Co"} }
    assert_redirected_to project_path(project)
    assert_equal 'Project was successfully updated.', flash[:notice]
    # assert_select "h2", "Project"
    # follow_redirect!
    # assert :success
    
  end

  test "should create and destroy a project" do
    get new_project_path(as: @user)
    assert_response :success

    post "/projects/", params: { project: { title: "XYZ Co API" } }
    assert_response :redirect
    follow_redirect!
    follow_redirect!
    assert_response :success
    assert_equal "Project was successfully created.", flash[:notice]

    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_path

  end

  test "should show a project and all its pages" do
    project = @user.projects.create(title: 'XYX API')
    get projects_path(as: @user)
    assert_response :success

    get project_path(project.id, as: @user)
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "XYX API"

    get project_servers_path(project)
    assert_response :success

    get project_host_name_path(project)
    assert_response :success

    get project_users_path(project)
    assert_response :success
  end
end
