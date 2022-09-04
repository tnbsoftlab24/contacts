require "application_system_test_case"

class Admin::Location::ProvincesTest < ApplicationSystemTestCase
  setup do
    @admin_location_province = admin_location_provinces(:one)
  end

  test "visiting the index" do
    visit admin_location_provinces_url
    assert_selector "h1", text: "Admin/Location/Provinces"
  end

  test "creating a Province" do
    visit admin_location_provinces_url
    click_on "New Admin/Location/Province"

    fill_in "Name", with: @admin_location_province.name
    click_on "Create Province"

    assert_text "Province was successfully created"
    click_on "Back"
  end

  test "updating a Province" do
    visit admin_location_provinces_url
    click_on "Edit", match: :first

    fill_in "Name", with: @admin_location_province.name
    click_on "Update Province"

    assert_text "Province was successfully updated"
    click_on "Back"
  end

  test "destroying a Province" do
    visit admin_location_provinces_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Province was successfully destroyed"
  end
end
