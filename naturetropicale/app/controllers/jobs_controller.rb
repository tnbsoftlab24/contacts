class JobsController < ApplicationController
  before_action :approved, unless: :devise_controller?
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authorized_enterprise, except: [:index,:show, :facturation, :job_finished, :assign_to]

  # GET /jobs
  # GET /jobs.json
  def index
    if current_user.enterprise?
      @jobs = Job.search(params[:search]).where('(owner_id =?) AND (status =?)',current_user.profile.id, 1 ).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
      @final_jobs = Job.where('(owner_id =?) AND (status !=?)',current_user.profile.id, 0 )
    elsif current_user.admin?
      @jobs = Job.search(params[:search]).where("status =?", 1 ).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
      @final_jobs = Job.where("(status !=?) ", 0 )
    else
      # @final_jobs = Job.where("status !=? AND  status =?  ", 0 , 1 )
      # @job_b ||= []
      # @profile_job = current_user.profile.multi_profiles.each do |test|
      #   @job_b << test.admin_job_category_id
      # end
      # @profile_jobs = Job.where('admin_job_category_id IN (?) OR poste = ? ', @job_b,current_user.profile.post_souhaite)
      @profile_jobs = Job.all
      @final_jobs =  @profile_jobs.where("status = ? OR (worker_name = ? AND status != ?) ", 1 ,current_user.profile.nom+" "+current_user.profile.prenom,0)
      @jobs = @final_jobs.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
      # admin_job_category_ids = current_user.profile.multi_profiles.pluck(:admin_job_category_id)
      @freefime_jobs = []
      current_user.profile.freetimes.each do |freetime|
        @free_job = @final_jobs.where("DATE(start_date) >= ? AND DATE(end_date) <= ?",freetime.start_date.to_date, freetime.end_date.to_date )
        @freefime_jobs << @free_job 
      end
      @freefime_jobs = @freefime_jobs.flatten
      p @freefime_jobs
    end
    # @jobs = Job.search(params[:search]).where("end_date >= ? AND (status =?)",Date.today, 1).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    # NotifyStartingJob.set(wait: 1.minutes).perform_later(current_user)
    # @profiles = Profile.joins(:user).where("profile.user.role = ?, ")
    # client = Twilio::REST::Client.new
    # client.messages.create({
    #   from: "+15815006464",
    #   to: "+13024762673",
    #   body: 'Hello there! This is a test'
    # })
  end

  def draft_jobs
    @jobs = Job.search(params[:search]).where("(owner_id =?) AND (status =?)",current_user.id, 0 ).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end

  def invitation_to
    @profile = Profile.find(params[:param1])
    @job = Job.find(params[:param2])
    @assign = Invitation.create(job_id: @job.id, profile_id: params[:param1])
    if current_user.enterprise?
      InviteProfileToJobMailer.invite_me(@profile, @job).deliver_now
      redirect_to request.referrer, notice: "#{@profile.nom} a été invité avec succès"
    elsif current_user.admin?
      @proposal = Proposal.create(job_id: @job.id  ,owner_id: @profile.id , information_complementaire:"Assignation par naturetropicale", status: 1)
      @job.update_columns(status: 2, new_proposal: true, worker_name: @proposal.owner.nom+" "+@proposal.owner.prenom )
      AssignProfileToJobMailer.assign_me(@profile, @job).deliver_now
      redirect_to request.referrer, notice: "Job Assigné à #{@profile.nom} avec succès"
    end
  end

  def enterprise_profile
    @profile = Profile.find(params[:id])
    redirect_to enterprise_profile_jobs_path
    # @job = Job.find(params[:param2])
    # @job.update_attributes(status: 2)
    # InviteProfileToJobMailer.invite_me(@profile, @job).deliver_now
  end

  def facturation
    @jobs = Job.all.order('start_date desc')
    # @proposals = Proposal.all
  end

  def users_course
    redirect_to  job_paiement_jobs_path(:id => params[:id])
  end

  def admin_job
    @profiles = Profile.all
    @jobs = Job.all
    @job = Job.new
  end

  def proposals_list
  end

  def set_price
    if set_job.status == 'draft'
      set_job.update_columns(status: 1, job_money: params[:jobmoney], employee_money: params[:employeemoney], end_date: params[:date])
      @paiement = Admin::Paiement.where(job_id: set_job.id).first
      @paiement.update_columns(job_amount: params[:jobmoney], worker_amount: params[:employeemoney])
    end
    redirect_to request.referrer
    flash[:notice] = 'Job publié avec succès'
    @users = User.where(role: 2)
    @profile1 = Profile.where('post_souhaite = ? AND approved =?', set_job.admin_job_category.title, true)
    @profile2 = Profile.joins(:multi_profiles).where('multi_profiles.profile_id IN (?) AND multi_profiles.admin_job_category_id =? AND approved =?', @users.ids, set_job.admin_job_category.id, true)
    profiles = @profile1 + @profile2
    NotifyStartingJob.set(wait: 12.minutes).perform_later(profiles, set_job)
  end

  def archived_job
    set_job.update_columns(status: 1, job_money: params[:jobmoney], employee_money: params[:employeemoney], end_date: params[:date])
    @paiement = Admin::Paiement.where(job_id: set_job.id).first
    @paiement.update_columns(job_amount: params[:jobmoney], worker_amount: params[:employeemoney])
    redirect_to request.referrer
    flash[:notice] = 'Job publié avec succès'
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @users = User.where(role: 2)
    @profile1 = Profile.where('post_souhaite = ? AND approved =?', set_job.admin_job_category.title, true)
    @profile2 = Profile.joins(:multi_profiles).where('multi_profiles.profile_id IN (?) AND multi_profiles.admin_job_category_id =? AND approved =?', @users.ids, set_job.admin_job_category.id, true)
    @profiles = @profile1 + @profile2
    @reviews = Review.all
    @proposals = Proposal.all.where(job_id: @job)
    @props = Proposal.all.where(owner_id: current_user.profile.id)
    @prop = set_job.proposal
    @proposal = Proposal.new
    @invitatons = Invitation.all
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @job.extras.build
  end

  def job_finished
    set_job.update_columns(status: 3)
    @job_owner = Profile.find_by_id(set_job.owner_id)
    @proposal =  set_job.proposal
    @proposal_owner = Profile.find_by_id(@proposal.owner_id)
    if @job_owner.total_amount.nil? || @proposal_owner.total_amount.nil? 
      @job_owner.update_columns(total_amount: set_job.job_money)
      @proposal_owner.update_columns(total_amount: set_job.employee_money)
    else
      @job_owner.update_columns(total_amount: @job_owner.total_amount - set_job.job_money)
      @proposal_owner.update_columns(total_amount: @proposal_owner.total_amount + set_job.employee_money)
    end
    JobFinishedMailer.job_ended(@job_owner, set_job).deliver_now
    redirect_to request.referrer, notice: 'Super ce job est terminé'
  end

  # GET /jobs/1/edit
  def edit
    @job.extras.build
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job creé avec succès.' }
        @paiement = Admin::Paiement.create!(paiement_date: @job.end_date, job_id: @job.id, enterprise_id: @job.owner_id, job_amount: @job.job_money)
        NewJobMailer.new_job(@job).deliver_now
        # NotifyStartingJob.set(wait: @job.start_date - 55.minutes).perform_later(current_user)
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    if @job.proposal.nil?
      respond_to do |format|
        if @job.update(job_params)
          format.html { redirect_to @job, notice: 'Job mise à jour avec succès.' }
          # p @job.draft_job_mins
          # p @job.draft_end_date
          # p Time.now 
          # p @job.start_date
          # p "rimboookrflkeq"
          # now = DateTime.now
          # before = DateTime.now + 2.hours
          # p before
        
          # difference_in_days = ((before - now) * 24 * 60).to_i
          # p difference_in_days
          # p "totokmdkmf"
          # p difference_in_days 

          # p "---------------"
          # nows = DateTime.now.in_time_zone(current_user.time_zone)
          # befores = @job.start_date
          # p DateTime.now.in_time_zone(current_user.time_zone) + 5.hours
          # p @job.start_date
        
          # vo = (nows - befores )
          # p (vo / 600 ) 
          # co = DateTime.parse(vo.to_i)
          # jo = co * 24 * 60
          # difference = ((befores - nows) / 60 ).to_i
          # p "lkflkbgbklktebgtekblkblkfdlkmbvkfdlk"
          # p  difference 
          # # p  (193 / 60)
          # p "---------------"
          # p @job.start_date.in_time_zone(current_user.time_zone)
          # p Time.zone.at(Date.current.to_time).to_datetime
          # p Time.zone.at(Date.current.to_time).to_datetime
          # p (Date.current.to_time - @job.start_date).to_datetime
          # p distance_of_time_in_words(Time.zone.at(Date.current.to_time).to_datetime, @job.start_date)
          # p (Date.today - @job.start_date) + @job.draft_end_date
          # NotifyStartingJob.set(wait: @job.start_date - 55.minutes).perform_later(current_user)
          @job.update_attributes(status: 0)
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to request.referrer
      flash[:error] = 'Une offre est en cours sur ce job, Veuillez la supprimer avant de proceder a la suppression de ce job'
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    if @job.proposal.nil?
      @job.destroy
      respond_to do |format|
        format.html { redirect_to jobs_url, notice: 'Job supprimé avec succès.' }
        format.json { head :no_content }
      end
    else
      redirect_to request.referrer, alert: 'Une offre est en cours sur ce job, Veuillez la supprimer avant de proceder à la suppression de ce job'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:poste, :information_specifique, :description, :start_date,:draft_job_mins, :end_date, :nbre_pause,:job_money, :job_money, :employee_money, :owner_id, :factor ,:status, :type_adress, :employee_dues, :admin_job_category_id, :job_adress ,:taux,:color,:search, :draft_end_date, extras_attributes: [:id, :designation,:prix_entreprise,:prix_employe, :job_id, :_destroy])
    end

    def authorized_enterprise
      unless current_user.enterprise? || current_user.admin?
        flash[:error] = 'Accès non autorisé'
        redirect_to root_path
      end
    end
end

