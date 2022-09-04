class PaiementsController < ApplicationController
  before_action :approved, unless: :devise_controller?
  before_action :set_paiement, only: [:show, :edit, :update, :destroy]
  before_action :authorized_worker, only: [:index, :create, :edit, :update, :destroy]

  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.where(owner_id: current_user.profile.id)
    # authorize Proposal
  end

  def billing
    @paiements = Paiement.where(subscription: false)
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paiement
      @paiement = Paiement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proposal_params
      params.require(:proposal).permit(:job_id, :owner_id, :information_complementaire)
    end

    def authorized_worker
      unless current_user.worker? || current_user.admin?
        flash[:error] = "Accès non autorisé"
        redirect_to root_path# halts request cycle
      end
    end
end
