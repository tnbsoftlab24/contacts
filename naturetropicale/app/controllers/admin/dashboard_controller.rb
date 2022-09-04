class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :admin_authorization
  def index
       @jobs = Job.search(params[:search]).where("(status !=?) ", 1 ).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
       @final_jobs = Job.where('admin_job_category_id IN (?) OR poste = ? AND status !=?', @job_b,current_user.profile.post_souhaite, 1).order('id desc')
       @provinces = Admin::Location::Province.all
       @regions = Admin::Location::Region.all
       @villes = Admin::Location::Ville.all
 end

  private
  
  def admin_authorization
    unless current_user.admin? || current_user.comptable? || current_user.assistant?
      flash[:error] = "Accès non autorisé"
      redirect_to root_path# halts request cycle
    end
  end
end
