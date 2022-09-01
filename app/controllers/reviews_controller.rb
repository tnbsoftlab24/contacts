class ReviewsController < ApplicationController
  before_action :approved, unless: :devise_controller?
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  def myreview(job)
    
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    respond_to do |format|
     
      if @review.save
        format.html { redirect_to job_path(@review.job.id), notice: 'Note creé avec succès.' }
        @profile = Profile.find_by_id(@review.profile_id)
        ReviewsMailer.new_review(@profile).deliver_now
        # message = "Bonjour avez été note. Veuillez vous connecter pour confirmer la facturation"
        # NexmoTextMessenger.new(message,@user_profile.actionnaire_tel).call
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to job_path(@review.job.id), notice: 'Note mise à jour avec succès.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Note supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:comment, :job_id, :profile_id, :rate, :worker_id)
    end
end
