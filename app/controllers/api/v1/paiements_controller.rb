module Api::V1
  class PaiementsController < Api::V1::ApplicationController

     respond_to :json
     def index
      @paiement = Paiement.where(id: params[:paiement]).first
      @paiement.update_columns(confirmation: true, confirmed_at: Date.today)
     end

     def mypaiements
      @paiement = Paiement.find(params[:id])
      @paiement = @paiement.update_columns(confirmation: true, confirmed_at: Date.today)
      render json: {:message => "Paiement confirmer avec succès", :confirmation => true}, status: 200
     end

  end
end