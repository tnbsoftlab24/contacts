require 'test_helper'

class Admin::JobCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_job_category = admin_job_categories(:one)
  end

  test "should get index" do
    get admin_job_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_job_category_url
    assert_response :success
  end

  test "should create admin_job_category" do
    assert_difference('Admin::JobCategory.count') do
      post admin_job_categories_url, params: { admin_job_category: { amount: @admin_job_category.amount, parent_id: @admin_job_category.parent_id, title: @admin_job_category.title } }
    end

    assert_redirected_to admin_job_category_url(Admin::JobCategory.last)
  end

  test "should show admin_job_category" do
    get admin_job_category_url(@admin_job_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_job_category_url(@admin_job_category)
    assert_response :success
  end

  test "should update admin_job_category" do
    patch admin_job_category_url(@admin_job_category), params: { admin_job_category: { amount: @admin_job_category.amount, parent_id: @admin_job_category.parent_id, title: @admin_job_category.title } }
    assert_redirected_to admin_job_category_url(@admin_job_category)
  end

  test "should destroy admin_job_category" do
    assert_difference('Admin::JobCategory.count', -1) do
      delete admin_job_category_url(@admin_job_category)
    end

    assert_redirected_to admin_job_categories_url
  end
end
