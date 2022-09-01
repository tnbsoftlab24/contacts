module Api::V1
  class ProposalsController < Api::V1::ApplicationController
    before_action :set_proposal, only: [:show, :update, :destroy]
    
    respond_to :json
    # GET /proposals.json
    def index
      @proposals = Proposal.where(owner_id: current_user.profile.id)
      render json: @proposals
    end

    # GET /proposals/1.json
    def show
      @proposal = Proposal.find(params[:id])
      render json: @proposal
    end

    # POST /proposals.json
    def create
      @proposal = Proposal.new(proposal_params)
      @job = Job.find(proposal_params[:job_id])
      if @job.proposal.nil?
        if @proposal.save
          render json: {:message => "Votre offre a été accepté", :already => false}, status: 200
          @proposal.update_columns(status: 1)
          @paiement = Admin::Paiement.where(job_id: @job.id).first
          @paiement.update_columns(worker_id: @proposal.owner_id)
          @job.update_columns(status: 2, new_proposal: true, worker_name: @proposal.owner.nom )
          AcceptProposalMailer.accept_proposal(@proposal).deliver_now
          # phone = @proposal.owner.num_tel
          # message = "Bonjour #{@proposal.owner.prenom} votre offre sur le job #{@proposal.job.poste} à été accepté"
          # NexmoTextMessenger.new(message,phone).call
          # owner_job_phone = @proposal.job.owner.actionnaire_tel
          # owner_job_message = "Bonjour #{@proposal.job.owner.nom_societe} votre job #{@proposal.job.poste} à reçu une nouvelle offre"
          # NexmoTextMessenger.new(owner_job_message, owner_job_phone).call
        else
          render json: {message: "Impossible de creer l'offre"}, status: 400
        end
      else 
        render json: {:message => "Une offre a déja accepté ", :already => true}, status: 200
      end
    end

    # PATCH/PUT /proposals/1.json
    def update
      @proposal = Proposal.find(params[:id])
      if @proposal
        @proposal.update(proposal_params)
        render json: {message: "L'offre a été modifié avec succès."}, status: 200
      else
        render json: {message: "Impossible de modifier l'offre."}, status: 400
      end
    end

    def destroy
      @proposal = Proposal.find(params[:id])
      if @proposal
        @proposal.destroy
        render json: {message: "L'offre a été supprimé avec succès"}, status: 200
      else
        render json: {message: "Impossible de supprimer l'offre"}, status: 400
      end
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_proposal
        @proposal = Proposal.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def proposal_params
        params.permit(:job_id, :owner_id, :information_complementaire)
      end
   end
end