require "application_system_test_case"

class SubSectionsTest < ApplicationSystemTestCase
  setup do
    @sub_section = sub_sections(:one)
  end

  test "visiting the index" do
    visit sub_sections_url
    assert_selector "h1", text: "Sub Sections"
  end

  test "creating a Sub section" do
    visit sub_sections_url
    click_on "New Sub Section"

    fill_in "Content", with: @sub_section.content
    fill_in "Section", with: @sub_section.section_id
    fill_in "Title", with: @sub_section.title
    click_on "Create Sub section"

    assert_text "Sub section was successfully created"
    click_on "Back"
  end

  test "updating a Sub section" do
    visit sub_sections_url
    click_on "Edit", match: :first

    fill_in "Content", with: @sub_section.content
    fill_in "Section", with: @sub_section.section_id
    fill_in "Title", with: @sub_section.title
    click_on "Update Sub section"

    assert_text "Sub section was successfully updated"
    click_on "Back"
  end

  test "destroying a Sub section" do
    visit sub_sections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sub section was successfully destroyed"
  end
end
