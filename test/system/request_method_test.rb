require "application_system_test_case"

class RequestMethodsTest < ApplicationSystemTestCase
  setup do
    user = create(:user)
    sign_in_as(user)
  end

  test "response content can be in any format" do
    visit projects_url
    click_on "New Project"
    fill_in "Title", with: "Ajax API"
    check "Generate default content"
    click_on "Create Project"
    click_on "eye-link"
    click_link "chapter-endpoints"
    click_on "Pets"
    click_on "Editor"
    click_on "Editor"
    click_link "method-get-all-pets"
    fill_in "Response content (JSON-formatted text)", with: "Useless non-Json text"
    click_on "Save"
    click_on "Editor"
    click_on "Editor"
    click_on "Editor"
    click_link "method-get-all-pets"
    fill_in "Response content (JSON-formatted text)", with: '{"body": "This is valid JSON"}'
  end

end