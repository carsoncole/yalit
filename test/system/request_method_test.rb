require "application_system_test_case"

class RequestMethodsTest < ApplicationSystemTestCase
  setup do
    user = create(:user, is_beta_user: true)
    sign_in_as(user)
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
    visit toggle_editor_url
    click_on "Pets"
    click_link "method-get-all-pets"
    click_link "chapter-endpoints"
    fill_in "Response content", with: "Useless non-Json text"
    click_on "Save"

    click_link "method-get-all-pets"
    fill_in "Response content", with: '{"body": "This is valid JSON"}'
  end

end