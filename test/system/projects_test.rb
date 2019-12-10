require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    user = create(:user)
    sign_in_as(user)
  end

  test "visiting the index" do
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
    click_on "Details"
    click_on("edit-link")
    assert_text "Project details are utilized in generating a valid OpenApi"
    fill_in "Title", with: "New API"
    click_on "Update Project"
    assert_selector "h1", text: "New API"

    # check main nav links
    click_on "archive-link"
    assert_selector "h1", text: "New API"
    click_on "folder-link"
    assert_selector "h1", text: "Projects"
    click_on("Settings", match: :first)
    click_on "eye-link"
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
    check "Generate default content"
    click_on "Create Project"

    assert_text "Project was successfully created"

    click_on "eye-link"
    click_on("Endpoints", match: :first)
    click_on "Introduction"
    click_on "Schema"
    assert_selector "h1", text: "ACME Company Inc. API"
    assert_text "This JSON is structured to comply with the OpenAPI specification"
    click_on "Download"
    # page.accept_confirm do
    #   click_on "Download", match: :first
    # end
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
