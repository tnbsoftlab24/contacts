require "application_system_test_case"

class Admin::Location::VillesTest < ApplicationSystemTestCase
  setup do
    @admin_location_ville = admin_location_villes(:one)
  end

  test "visiting the index" do
    visit admin_location_villes_url
    assert_selector "h1", text: "Admin/Location/Villes"
  end

  test "creating a Ville" do
    visit admin_location_villes_url
    click_on "New Admin/Location/Ville"

    fill_in "Amount", with: @admin_location_ville.amount
    fill_in "Name", with: @admin_location_ville.name
    fill_in "Region", with: @admin_location_ville.region_id
    click_on "Create Ville"

    assert_text "Ville was successfully created"
    click_on "Back"
  end

  test "updating a Ville" do
    visit admin_location_villes_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @admin_location_ville.amount
    fill_in "Name", with: @admin_location_ville.name
    fill_in "Region", with: @admin_location_ville.region_id
    click_on "Update Ville"

    assert_text "Ville was successfully updated"
    click_on "Back"
  end

  test "destroying a Ville" do
    visit admin_location_villes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ville was successfully destroyed"
  end
end
