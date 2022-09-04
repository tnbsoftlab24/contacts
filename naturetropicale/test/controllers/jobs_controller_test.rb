require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get jobs_url
    assert_response :success
  end

  test "should get new" do
    get new_job_url
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post jobs_url, params: { job: { description: @job.description, end_date: @job.end_date, nbre_pause: @job.nbre_pause, post_category_id: @job.post_category_id, profile_id: @job.profile_id, start_date: @job.start_date, title: @job.title } }
    end

    assert_redirected_to job_url(Job.last)
  end

  test "should show job" do
    get job_url(@job)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_url(@job)
    assert_response :success
  end

  test "should update job" do
    patch job_url(@job), params: { job: { description: @job.description, end_date: @job.end_date, nbre_pause: @job.nbre_pause, post_category_id: @job.post_category_id, profile_id: @job.profile_id, start_date: @job.start_date, title: @job.title } }
    assert_redirected_to job_url(@job)
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete job_url(@job)
    end

    assert_redirected_to jobs_url
  end
end
