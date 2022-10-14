require "application_system_test_case"

class LandingPageTest < ApplicationSystemTestCase
  test "visting the landing page" do
    visit root_url
    assert_text "Yalit 2022. All Rights Reserved."

    assert_selector "form", count: 2 # sign up forms
  end

  test "sign in process works" do
    user = create(:user)

    visit root_url
    click_on "Sign In"

    assert_selector "h1", text: "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign in"
  end


  test "forgot password" do
    user = create(:user)

    visit root_url
    click_on "Sign In"
    click_on "Forgot password?"

    assert_selector "h1", text: "Reset your password"
    fill_in "Email address", with: user.email
    click_on "Reset password"

    assert_text "You will receive an email within the next few minutes"
  end
end
