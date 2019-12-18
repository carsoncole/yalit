require "application_system_test_case"

class RequestMethodsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in_as(@user)
  end

  test "response content can be in any format" do
    visit projects_url
    click_link "New Project"
    fill_in "Title", with: "Ajax API"
    check "Generate default content"
    click_button "Create Project"
    # within "#main-nav" do
    #   click_on "archive-link"
    # end
    project = @user.projects.last

    within "#project-nav" do
        click_link "Servers"
    end
    click_link "Add server"
    fill_in "Url", with: "https://postman-echo.com/get"
    fill_in "Description", with: "This is a test endpoint hosted by Postman"
    check "Use for Testing"
    click_on "Save"

    within "#project-nav" do
      click_on "View"
    end
    visit project_toggle_editor_url(project.id)
    save_screenshot('tmp/screenshots/something.png')
    click_on "View"
    within("#side-nav") do
      click_on "Endpoints"
      click_on "Pets"
    end
    within("#request-method") do
      click_link("method-get-all-pets")
    end
    fill_in "Response body", with: "Useless non-Json text"
    click_on "Save"

    assert_selector "#interaction", text: "REQUEST"
    assert_selector "#interaction", text: "RESPONSE"
    assert_selector "pre", text: "Useless non-Json text"
  end

end