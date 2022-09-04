module Api::V1
  class VillesController < Api::V1::ApplicationController
    # before_action :set_proposal, only: [:index]

    respond_to :json
    def index
      @villes = Admin::Location::Ville.all
      render json: @villes
    end
   end
end