require "application_system_test_case"

class SchemaTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in_as(@user)
  end

  test "side nav links with a basic content project" do
    project = create(:project, generate_default_content: false)
    @user.user_projects.create(project: project)

    visit project_url(project)
    click_on "eye-link"

    click_on "Schema"
    assert_text '"openapi": "3.0.2"'
  end

  test "side nav links with a default content project" do
    project = create(:project, generate_default_content: true)
    @user.user_projects.create(project: project)

    visit project_url(project)
    click_on "eye-link"

    click_on "Schema"
    assert_text '"openapi": "3.0.2"'
  end

  #TODO Test Swagger
  test "Swagger link" do
    assert true
  end

  #TODO Test Download
  test "Download link" do
    assert true
  end
end
