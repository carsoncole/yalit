require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in_as(@user)
  end

  test "visiting the index, creating, and viewing" do
    visit projects_url
    assert_selector "h1", text: "Projects"

    click_on "New Project"
    fill_in "Title", with: "Ajax API"
    click_on "Create Project"
    assert_text "Project was successfully created"
    assert_selector "h1", text: "Ajax API"

    click_on "Hosting"
    assert_text "Host name"

    click_on "Users"
    assert_text "Owner" # there should be one owner

    click_on "Servers"
    assert_text "Add server" # there should be one owner

    click_on "Details"
    assert_text "Terms of service"

    click_on "View"
    assert_selector "h1", text: "Default"
  end

  test "main nav links with a default content project" do
    project = create(:project, generate_default_content: true)
    @user.user_projects.create(project: project)

    visit project_url(project)
    click_on "archive-link"
    assert_selector "h1", text: "Widget Co. API"

    click_on "folder-link"
    assert_selector "h1", text: "Projects"
    assert_selector "td", text: "Settings"

    click_on "Settings"
    click_on "eye-link"
    assert_selector "h1", text: "Widget Co. API"
  end

  test "main nav links with a basic content project" do
    project = create(:project, generate_default_content: false)
    @user.user_projects.create(project: project)

    visit project_url(project)
    click_on "archive-link"
    assert_selector "h1", text: "Widget Co. API"

    click_on "folder-link"
    assert_selector "h1", text: "Projects"
    assert_selector "td", text: "Settings"

    click_on "Settings"
    click_on "eye-link"
    assert_selector "h1", text: "Widget Co. API"
  end

  test "creating and updating a Project" do
    visit projects_url
    click_on "New Project"

    fill_in "Title", with: "ACME Company Inc. API"
    click_on "Create Project"

    assert_text "Project was successfully created"

    visit projects_url
    click_on("Settings", match: :first)
    click_on("edit-link")

    fill_in "Title", with: "ACME NEW Company Inc. API"
    click_on "Update Project"

    assert_text "Project was successfully updated"
  end

  test "creating a populated Project" do
    visit projects_url
    click_on "New Project"
    fill_in "Title", with: "ACME Company Inc. API"
    fill_in "Description", with: "ACME Company's API documentation."
    click_on "Create Project"

    assert_text "Project was successfully created"

    click_on "Servers"
    click_on "Add server"
    fill_in "Url", with: "https://acme.com/api/v1"
    fill_in "Description", with: "Acme production server"
    click_button "Save"

    click_on "Users"
    assert_text @user.email

    click_on "View"
    click_on "Schema"
    assert_text '"title": "ACME Company Inc. API"'

    project = @user.projects.first
    visit project_schema_url(project.id, editing_mode: true)
    click_on "Chapter"


  end


  test "destroying a Project" do
    visit projects_url
    click_on "New Project"

    fill_in "Title", with: "ACME Company Inc. API"
    click_on "Create Project"

    page.accept_confirm do
      click_on "DESTROY PROJECT", match: :first
    end

    assert_text "Project was successfully destroyed"
  end
end
