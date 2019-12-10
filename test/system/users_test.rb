require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
  end

  test "a Martech user enters their email on landing page" do
   visit root_url
   fill_in "primary-email-field", with: martech_email
   click_on "primary-signup-button"
   fill_in "Password", with: Faker::Internet.password
   click_on "Sign up"
   assert_selector "h1", text: "Projects"
  end

  test "a new Martech user signing up" do
   visit sign_up_url
   fill_in "Email", with: martech_email
   fill_in "Password", with: Faker::Internet.password
   click_on "Sign up"
   assert_selector "h1", text: "Projects"
  end

  test "a non-Martech user enters their email on landing page" do
   visit root_url
   fill_in "primary-email-field", with: Faker::Internet.email
   click_on "primary-signup-button"
   fill_in "Password", with: Faker::Internet.password
   click_on "Sign up"
   assert_selector "#error_explanation"
   assert_selector "li", text: "Email is not an allowable email domain"
  end

  test "a non-Martech user signing up" do
   visit sign_up_url
   fill_in "Email", with: Faker::Internet.email
   fill_in "Password", with: Faker::Internet.password
   click_on "Sign up"
   assert_selector "#error_explanation"
   assert_selector "li", text: "Email is not an allowable email domain"
  end

  test "projects index page after signing in" do
    sign_in_as(users(:standard))
    assert_selector "h1", text: "Projects"
  end

  test "user succesfully signing out from the main nav" do
    sign_in_as(users(:standard))
    find("#navbarDropdown").click
    click_on "Sign out"
    assert_selector "h1", text: "Sign in"
  end

  #TODO user test
  test "only owner can destroy owned projects" do
  end
end
