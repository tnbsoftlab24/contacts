class ProposalsController < ApplicationController
  before_action :approved, unless: :devise_controller?
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]
  before_action :authorized_worker, only: [:index, :create, :edit, :update, :destroy]

  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.where(owner_id: current_user.profile.id)
    # authorize Proposal
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show; end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
  end

  # GET /proposals/1/edit
  def edit; end

  def accept_proposal
    # p "zozozozozoz"
    # # p proposal_params
    # p "check here dear accept_proposal zone"
    # # p params[:proposal][:job_id]
  end

  def reject_proposal
    set_proposal.update_attributes(status: 2)
    redirect_to request.referrer, notice: 'Vous avez rejeté le proposal'
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(proposal_params)
    @job = Job.find(proposal_params[:job_id])
    if @job.proposal.nil?
      respond_to do |format|
        if @proposal.save
          format.html { redirect_to @job, notice: "Offre creé avec succès et acceptée par l'entreprise." }
          format.json { render :show, status: :created, location: @proposal }
          @proposal.update_columns(status: 1)
          @paiement = Admin::Paiement.where(job_id: @job.id).first
          @paiement.update_columns(worker_id: @proposal.owner_id)
          @job.update_columns(status: 2, new_proposal: true, worker_name: @proposal.owner.nom+' '+@proposal.owner.prenom )
          AcceptProposalMailer.accept_proposal(@proposal).deliver_now
          phone = @proposal.owner.num_tel
          message = "Bonjour #{@proposal.owner.prenom} votre offre sur le job #{@proposal.job.poste} à été accepté"
          NexmoTextMessenger.new(message,phone).call
          owner_job_phone = @proposal.job.owner.actionnaire_tel
          owner_job_message = "Bonjour #{@proposal.job.owner.nom_societe} votre job #{@proposal.job.poste} à reçu une nouvelle offre"
          NexmoTextMessenger.new(owner_job_message, owner_job_phone).call
        else
          format.html { render :new }
          format.json { render json: @proposal.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to request.referrer
      flash[:error] = "Ce Job n'est plus disponible choisissez en un autre"
    end
  end 

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    respond_to do |format|
      if @proposal.update(proposal_params)
        format.html { redirect_to @proposal, notice: 'Proposition mise à jour avec succès.' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @job_owner = Profile.find_by_id(@proposal.job.owner_id)
    @proposal_owner =  Profile.find_by_id( @proposal.owner_id)
    @job_owner.update_columns(total_amount: @job_owner.total_amount + @proposal.job.job_money)
    @proposal_owner.update_columns(total_amount: @proposal_owner.total_amount - @proposal.job.employee_money)
    @proposal.job.update_columns(status: 1)
    @proposal.job.invitations&.destroy_all
    @proposal.job.reviews&.destroy_all
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: 'Proposition supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def proposal_params
    params.require(:proposal).permit(:job_id, :owner_id, :information_complementaire)
  end

  def authorized_worker
    unless current_user.worker? || current_user.admin?
      flash[:error] = 'Accès non autorisé'
      redirect_to root_path# halts request cycle
    end
  end
end
