require 'test_helper'

class Admin::Location::VillesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_location_ville = admin_location_villes(:one)
  end

  test "should get index" do
    get admin_location_villes_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_location_ville_url
    assert_response :success
  end

  test "should create admin_location_ville" do
    assert_difference('Admin::Location::Ville.count') do
      post admin_location_villes_url, params: { admin_location_ville: { amount: @admin_location_ville.amount, name: @admin_location_ville.name, region_id: @admin_location_ville.region_id } }
    end

    assert_redirected_to admin_location_ville_url(Admin::Location::Ville.last)
  end

  test "should show admin_location_ville" do
    get admin_location_ville_url(@admin_location_ville)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_location_ville_url(@admin_location_ville)
    assert_response :success
  end

  test "should update admin_location_ville" do
    patch admin_location_ville_url(@admin_location_ville), params: { admin_location_ville: { amount: @admin_location_ville.amount, name: @admin_location_ville.name, region_id: @admin_location_ville.region_id } }
    assert_redirected_to admin_location_ville_url(@admin_location_ville)
  end

  test "should destroy admin_location_ville" do
    assert_difference('Admin::Location::Ville.count', -1) do
      delete admin_location_ville_url(@admin_location_ville)
    end

    assert_redirected_to admin_location_villes_url
  end
end
