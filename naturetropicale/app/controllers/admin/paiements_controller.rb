class Admin::PaiementsController < ApplicationController
  def index
    @jobs = Job.all.where(status: 3)
    @profile =  Profile.find_by_id(params[:id])
  end

  def create_paiement
    @paiement = Paiement.create(comment: params[:comment], received: params[:received], montant: params[:montant])
    @user_profile = Profile.find_by_id(params[:received])
    if @user_profile.user.enterprise?
      @user_profile.update_columns(total_amount: @user_profile.total_amount - params[:montant])
    else @user_profile.user.worker?
      @user_profile.update_columns(total_amount: user_profile.total_amount - params[:montant] )
    end
    format.html { redirect_to profile_path(@user_profile.id), notice: 'Paiement creé avec succès.' }
  end

  def new
    @paiement = Admin::Paiement.new
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @paiement = Paiement.new(job_params)

    respond_to do |format|
      if @paiement.save
        format.html { redirect_to @paiement, notice: 'Job creé avec succès.' }
        format.json { render :show, status: :created, location: @paiement }
      else
        format.html { render :new }
        format.json { render json: @paiement.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paiement
      @paiement = Paiement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paiement_params
      params.require(:paiement).permit(:comment, :job_id, :received, :montant,:status, :admin_job_category_id)
    end
end
