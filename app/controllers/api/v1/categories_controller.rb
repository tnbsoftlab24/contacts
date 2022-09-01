module Api::V1
  class CategoriesController < Api::V1::ApplicationController
    # before_action :set_proposal, only: [:index]

    respond_to :json
    def index
      @categories = Admin::JobCategory.all
      render json: @categories
    end
   end
end