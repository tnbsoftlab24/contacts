require 'test_helper'

class Admin::Location::RegionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_location_region = admin_location_regions(:one)
  end

  test "should get index" do
    get admin_location_regions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_location_region_url
    assert_response :success
  end

  test "should create admin_location_region" do
    assert_difference('Admin::Location::Region.count') do
      post admin_location_regions_url, params: { admin_location_region: { name: @admin_location_region.name, province_id: @admin_location_region.province_id } }
    end

    assert_redirected_to admin_location_region_url(Admin::Location::Region.last)
  end

  test "should show admin_location_region" do
    get admin_location_region_url(@admin_location_region)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_location_region_url(@admin_location_region)
    assert_response :success
  end

  test "should update admin_location_region" do
    patch admin_location_region_url(@admin_location_region), params: { admin_location_region: { name: @admin_location_region.name, province_id: @admin_location_region.province_id } }
    assert_redirected_to admin_location_region_url(@admin_location_region)
  end

  test "should destroy admin_location_region" do
    assert_difference('Admin::Location::Region.count', -1) do
      delete admin_location_region_url(@admin_location_region)
    end

    assert_redirected_to admin_location_regions_url
  end
end
