require "application_system_test_case"

class Admin::Location::RegionsTest < ApplicationSystemTestCase
  setup do
    @admin_location_region = admin_location_regions(:one)
  end

  test "visiting the index" do
    visit admin_location_regions_url
    assert_selector "h1", text: "Admin/Location/Regions"
  end

  test "creating a Region" do
    visit admin_location_regions_url
    click_on "New Admin/Location/Region"

    fill_in "Name", with: @admin_location_region.name
    fill_in "Province", with: @admin_location_region.province_id
    click_on "Create Region"

    assert_text "Region was successfully created"
    click_on "Back"
  end

  test "updating a Region" do
    visit admin_location_regions_url
    click_on "Edit", match: :first

    fill_in "Name", with: @admin_location_region.name
    fill_in "Province", with: @admin_location_region.province_id
    click_on "Update Region"

    assert_text "Region was successfully updated"
    click_on "Back"
  end

  test "destroying a Region" do
    visit admin_location_regions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Region was successfully destroyed"
  end
end
