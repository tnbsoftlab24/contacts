require 'test_helper'

class Admin::Location::ProvincesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_location_province = admin_location_provinces(:one)
  end

  test "should get index" do
    get admin_location_provinces_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_location_province_url
    assert_response :success
  end

  test "should create admin_location_province" do
    assert_difference('Admin::Location::Province.count') do
      post admin_location_provinces_url, params: { admin_location_province: { name: @admin_location_province.name } }
    end

    assert_redirected_to admin_location_province_url(Admin::Location::Province.last)
  end

  test "should show admin_location_province" do
    get admin_location_province_url(@admin_location_province)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_location_province_url(@admin_location_province)
    assert_response :success
  end

  test "should update admin_location_province" do
    patch admin_location_province_url(@admin_location_province), params: { admin_location_province: { name: @admin_location_province.name } }
    assert_redirected_to admin_location_province_url(@admin_location_province)
  end

  test "should destroy admin_location_province" do
    assert_difference('Admin::Location::Province.count', -1) do
      delete admin_location_province_url(@admin_location_province)
    end

    assert_redirected_to admin_location_provinces_url
  end
end
