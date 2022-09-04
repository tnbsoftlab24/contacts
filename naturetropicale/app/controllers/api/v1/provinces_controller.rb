module Api::V1
  class ProvincesController < Api::V1::ApplicationController
    # before_action :set_proposal, only: [:index]

    respond_to :json
    def index
      @provinces = Admin::Location::Province.all
      render json: @provinces
    end
   end
end