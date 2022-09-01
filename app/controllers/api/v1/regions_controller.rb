module Api::V1
  class RegionsController < Api::V1::ApplicationController
    # before_action :set_proposal, only: [:index]

    respond_to :json
    def index
      @regions = Admin::Location::Region.all
      render json: @regions
    end
   end
end