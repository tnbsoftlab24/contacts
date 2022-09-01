module Api::V1
  class JobsController < Api::V1::ApplicationController

     respond_to :json
     def index
        @job_b ||= []
        @profile_job = current_user.profile.multi_profiles.each do |test|
          @job_b << test.admin_job_category_id
        end
        @profile_jobs = Job.where('admin_job_category_id IN (?) OR poste = ?', @job_b,current_user.profile.post_souhaite)
        @final_jobs =  @profile_jobs.where("status !=? ", 0)
        @jobs = @final_jobs
       render json: @jobs
     end

     # GET /jobs/1.json
    def show
      @job = Job.find(params[:id])
      render json: @job
    end
   end
end