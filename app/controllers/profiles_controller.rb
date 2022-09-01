class ProfilesController < ApplicationController
  before_action :approved,:except =>  [:show, :edit, :update]
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :profile_authorization, only: [:index]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles_confirmed = Profile.where(approved: true).search(params[:search]).paginate(:per_page => 20, :page => params[:profile_page])
    @profiles_unconfirmed = Profile.where("approved IS ?",nil).search(params[:search]).paginate(:per_page => 20, :page => params[:home_page])
    @profiles_suspended = Profile.where("approved IS ?",false).search(params[:search]).paginate(:per_page => 20, :page => params[:suspended_page])
    @profiles_uncreated = Profile.joins(:user).where("approved IS ? AND role !=? AND pricing_plan IS ?",  nil, 0, nil).search(params[:search]).paginate(:per_page => 20, :page => params[:uncreated_page])
    @users = User.search(params[:search]).paginate(:per_page => 2, :page => params[:page])
    @jobs = Job.all
  end

  def paiement_history
    @proposals = Proposal.all
    @jobsworker = Proposal.all
    @jobsenterprise = Job.all
    @profile = Profile.find_by_id(params[:id])
    if @profile.user.worker?
      @paiements = Paiement.where(owner_id: @profile.id)
    elsif @profile.user.enterprise?
      @paiements = Paiement.where(owner_id: @profile.id)
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @experiences = Experience.all
    @proposals = Proposal.all
    @jobsworker = Proposal.where(status: 2)
    @jobsenterprise = Job.all
    @profile = Profile.find(params[:id])
    if @profile.user.worker?
      @paiements = Paiement.where(owner_id: @profile.id)
    elsif @profile.user.enterprise?
      @paiements = Paiement.where(owner_id: @profile.id)
    end
    @paiement = Paiement.new
  end

  def confirmation_paiement
    @paiement = Paiement.where(id: params[:paiement]).first
    if current_user.worker?
      # current_user.profile.update_columns(total_amount: current_user.profile.total_amount - @paiement.montant)
      @paiement.update_columns(confirmation: true, confirmed_at: Date.today, admin_confirmation: true)
    elsif current_user.admin?
      @user_profile = Profile.find(@paiement.owner_id)
      @user_profile.update_attributes(total_amount: total_paiement(@user_profile.id))
      @paiement.update_columns(confirmation: true, confirmed_at: Date.today)
      # end
    end
    redirect_to request.referrer, notice: 'Merci pour votre confirmation'
  end

  def canceled_paiement
    @paiement = Paiement.where(id: params[:paiement]).first
    @profile = Profile.find_by_id(@paiement.owner_id)
    @paiement.destroy
    @profile.update_columns(total_amount: total_paiement(@profile.id))
    redirect_to request.referrer, notice: 'Paiement annuler avec succès'
  end

  def pay_bill
    @paiement = Paiement.where(id: params[:paiement]).first
    @paiement.update_columns(admin_confirmation: true)
    redirect_to request.referrer, notice: 'Merci pour votre confirmation'
  end

  # GET /profiles/new
  def new
    if !current_user.profile.present?
      @profile = Profile.new
      @profile.multi_profiles.build
      @profile.multi_places.build
      @profile.tarifs.build
    end
  end

  # GET /profiles/1/edit
  def edit
    if current_user.profile != @profile && (!current_user.admin? || current_user.assistant?)
      flash[:error] = 'Accès non autorisé'
      redirect_to "/profiles/#{current_user.profile.id}/edit" unless request.fullpath == "/profiles/#{current_user.profile.id}/edit"
    end
    @categories = Admin::JobCategory.all
    @profile.experiences.build
    @profile.multi_profiles.build
    @profile.multi_places.build
    @profile.tarifs.build
    @provinces = Admin::Location::Province.all
    @regions = Admin::Location::Region.all
    @villes = Admin::Location::Ville.all
  end

  def enterprise_profile
    # p params[:id]
    # @profile = Profile.find(params[:id])
    redirect_to new_job_path(:id => params[:id])
    # redirect_to :back
    # @job = Job.find(params[:param2])
    # @job.update_attributes(status: 2)
    # InviteProfileToJobMailer.invite_me(@profile, @job).deliver_now
  end

  def post_profile
    # p "groupsssss"
    # p params[:id]
    # @profile = Profile.find(params[:id])
    # p "yeahhhhh"
    # redirect_to controller: 'jobs', action: 'create', id: params[:profile_id] 
    redirect_to  new_user_path(:id => 1)
    # @job = Job.find(params[:param2])
    # @job.update_attributes(status: 2)
    # InviteProfileToJobMailer.invite_me(@profile, @job).deliver_now
  end

  def create_paiement
    @value = params[:paiement][:montant]
    @montant = @value.to_f
    @paiement = Paiement.create(comment: params[:paiement][:comment], received: params[:paiement][:received], montant: @montant, owner_id: params[:paiement][:owner_id])
    @user_profile = Profile.find_by_id(params[:paiement][:owner_id])
    if @user_profile.user.worker?
      @user_profile.update_columns(total_amount: @user_profile.total_amount - @montant)
      WorkerPaiementMailer.new_paiement(@user_profile.user).deliver_now
      # message = "Bonjour #{@user_profile.prenom} vous avez reçu une nouveau paiement. Veuillez vous connecter pour le confirmer"
      # NexmoTextMessenger.new(message,@user_profile.num_tel).call
    else
      EnterpriseBillMailer.new_bill(@user_profile).deliver_now
      # message = "Bonjour #{@user_profile.nom_societe} vous avez reçu une nouvelle facture. Veuillez vous connecter pour confirmer la facturation"
      # NexmoTextMessenger.new(message,@user_profile.actionnaire_tel).call
    end
    redirect_to request.referrer, notice: 'Paiement creé avec succès.'
  end

  def activate_profile
    set_profile.update_attribute(approved: true)
    redirect_to request.referrer, notice: 'Profile Activate'
  end

  def disabled_profile
    set_profile.update_attribute(status: false)
    redirect_to request.referrer, notice: 'Profile Disabled'
  end


  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @user = current_user
    respond_to do |format|
      if @profile.save
        format.html { redirect_to  root_path, notice: 'Profile crée avec succès.' }
        format.json { render :show, status: :created, location: @profile }
        @user = @profile.user.email
        ValidateAccountMailer.new_profile(@user, @profile).deliver_now
        NewUserWaitingForApprovalMailer.activate_profile(@user,@profile).deliver_now
        if @profile.nom.blank? || @profile.nom_societe.blank?
          @profile.user.update_columns(is_new: true)
        end
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        @user =  @profile.user.email
        format.html { redirect_to @profile, notice: 'Profile mise à jour avec succès.' }
        format.json { render :show, status: :ok, location: @profile }
        if !@profile.nom.blank? || !@profile.nom_societe.blank?
          @profile.user.update_columns(is_new: false)
          # NewUserWaitingForApprovalMailer.activate_profile(@user,@profile).deliver_now
        end

        if @profile.saved_change_to_pricing_plan? &&  @profile.user.souscription.end_date.nil?
          @profile.user.souscription.update_columns(pricing_plan: @profile.pricing_plan.to_s, start_date: Date.today, end_date:  1.year.since(Date.today))
          if @profile.user.worker?
            @profile.update_columns(total_amount: @profile.pricing_plan == "free" ? @profile.total_amount - 0 : @profile.total_amount - 99)
            Paiement.create(comment: 'Abonnement annuelle Naturetropicale', montant: @profile.total_amount , owner_id: @profile.id, subscription: true)
          elsif @profile.user.enterprise?
            @profile.update_columns(total_amount: @profile.pricing_plan == "free" ? @profile.total_amount - 0 : @profile.total_amount - 249)
            Paiement.create(comment: 'Abonnement Annuelle Naturetropicale', montant: @profile.total_amount , owner_id: @profile.id, subscription: true)
          end
        elsif @profile.saved_change_to_pricing_plan? && @profile.user.souscription.end_date <= (Date.today)
          @profile.user.souscription.update_columns(pricing_plan: @profile.pricing_plan.to_s, start_date: Date.today, end_date: 1.year.since(Date.today))
          if @profile.user.worker?
            @profile.update_columns(total_amount: @profile.pricing_plan == "free" ? @profile.total_amount - 0 : @profile.total_amount - 99)
            Paiement.create(comment: 'Abonnement Annuelle Naturetropicale', montant: @profile.total_amount , owner_id: @profile.id,  subscription: true)
          elsif @profile.user.enterprise?
            @profile.update_columns(total_amount: @profile.pricing_plan == "free" ? @profile.total_amount - 0 : @profile.total_amount - 249)
            Paiement.create(comment: 'Abonnement Annuelle Naturetropicale', montant: @profile.total_amount , owner_id: @profile.id, subscription: true)
          end
        end
        @user = @profile.user.email
        message = "Bonjour #{@profile.prenom}! Votre compte Nature Tropicale a été activé avec succès. Connectez-vous dès maintenant pour postuler aux offres disponibles."
        if @profile.user.worker?
          phone = @profile.num_tel
        elsif @profile.user.enterprise?
          phone = @profile.actionnaire_tel
        end
        if @profile.approved? && action_name === "update" && current_user.admin?
          @profile.user.update_columns(is_validate: true)
          if @profile.saved_change_to_approved?
            AccountActivateMailer.account_activate(@user,@profile).deliver_now
            NexmoTextMessenger.new(message,phone).call
          end
        elsif !@profile.approved? && action_name === "update" && current_user.admin?
          @profile.user.update_columns(is_validate: false)
          if @profile.saved_change_to_approved?
            AccountSuspendMailer.reject_profile(@user,@profile).deliver_now
          end
        end
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:nom, :prenom, :bio,:num_tel, :nationalite,:adresse,
        :adresse1, :adresse2, :region, :province, :pays,:code_postal,:ville,:time_zone, :quartier,
        :post_souhaite, :nom_contact, :tel_contact, :email_contact, :sondage, 
        :nom_societe,:pricing_plan, :reference,:num_entreprise_quebec, :statut_juridique, :nom_actionnaire_principal, 
        :actionnaire_tel, :actionnaire_email, :photo, :cv, :user_id,:approved, 
        experiences_attributes: [:id, :description,:profile_id ,:nb_experience, :admin_job_category_id, :diplome, :_destroy], 
        multi_profiles_attributes: [:id, :admin_job_category_id,:prix, :profile_id, :_destroy],
        tarifs_attributes: [:id, :admin_job_category_id,:prix, :profile_id,:_destroy],
        multi_places_attributes: [:id, :adresse, :profile_id,:_destroy, :adresse1, :adresse2, :country, :region, :province, :code_postal,:ville],
        freetimes_attributes: [:id, :day, :profile_id,:_destroy, :start_date, :end_date ])
      # params.require(:profile).permit(:nom, :prenom, :num_tel, :nationalite, :adresse1, :adresse2, :ville, :region, :province, :pays, :code_postal, :post_souhaite, :nom_contact, :tel_contact, :email_contact, :sondage, :nom_societe, :num_entreprise_quebec, :statut_juridique, :nom_actionnaire_principal, :actionnaire_tel, :actionnaire_email, :photo, :cv, :user_id,:approved, Experience.attribute_names.map(&:to_sym).push(:_destroy))
    end

    def profile_authorization
      unless current_user.admin? || current_user.assistant?
        flash[:error] = "Accès non autorisé"
        redirect_to root_path# halts request cycle
      end
    end
end
