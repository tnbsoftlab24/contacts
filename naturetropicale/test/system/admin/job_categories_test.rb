require "application_system_test_case"

class Admin::JobCategoriesTest < ApplicationSystemTestCase
  setup do
    @admin_job_category = admin_job_categories(:one)
  end

  test "visiting the index" do
    visit admin_job_categories_url
    assert_selector "h1", text: "Admin/Job Categories"
  end

  test "creating a Job category" do
    visit admin_job_categories_url
    click_on "New Admin/Job Category"

    fill_in "Amount", with: @admin_job_category.amount
    fill_in "Parent", with: @admin_job_category.parent_id
    fill_in "Title", with: @admin_job_category.title
    click_on "Create Job category"

    assert_text "Job category was successfully created"
    click_on "Back"
  end

  test "updating a Job category" do
    visit admin_job_categories_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @admin_job_category.amount
    fill_in "Parent", with: @admin_job_category.parent_id
    fill_in "Title", with: @admin_job_category.title
    click_on "Update Job category"

    assert_text "Job category was successfully updated"
    click_on "Back"
  end

  test "destroying a Job category" do
    visit admin_job_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job category was successfully destroyed"
  end
end
