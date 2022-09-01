class PostCategoriesController < ApplicationController
  before_action :approved, unless: :devise_controller?
  before_action :set_post_category, only: [:show, :edit, :update, :destroy]

  # GET /post_categories
  # GET /post_categories.json
  def index
    
    @post_category = nil
    @post_categories = PostCategory.all
    # @post_categories = PostCategory.find(:all, :conditions => {:parent_id => nil } )

  end

  # GET /post_categories/1
  # GET /post_categories/1.json
  def show
    # Find the category belonging to the given id
    @post_category = PostCategory.find(params[:id])
    # Grab all sub-categories
    @post_categories = @post_category.subcategories
    # We want to reuse the index renderer:
    render :action => :index
  end

  # GET /post_categories/new
  def new
    # @post_category = PostCategory.new
    @post_category  = PostCategory.new
    @post_category.parent = PostCategory.find(params[:id]) unless params[:id].nil?
  end

  # GET /post_categories/1/edit
  def edit
  end

  # POST /post_categories
  # POST /post_categories.json
  def create
    @post_category = PostCategory.new(params.require(:post_category).permit(:title, :parent_id))
    # @proposal = Proposal.new(params.require(:proposal).permit(:status, :country_id,

    respond_to do |format|
      if @post_category.save
        format.html { redirect_to @post_category, notice: 'Categorie crée avec succès.' }
        format.json { render :show, status: :created, location: @post_category }
      else
        format.html { render :new }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_categories/1
  # PATCH/PUT /post_categories/1.json
  def update
    respond_to do |format|
      if @post_category.update(post_category_params)
        format.html { redirect_to @post_category, notice: 'Categorie mise à jour avec succès.' }
        format.json { render :show, status: :ok, location: @post_category }
      else
        format.html { render :edit }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_categories/1
  # DELETE /post_categories/1.json
  def destroy
    @post_category.destroy
    respond_to do |format|
      format.html { redirect_to post_categories_url, notice: 'Categorie supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_category
      @post_category = PostCategory.find(params[:id])
    end

    # def set_select_collections
    #   @post_categories = PostCategory.find(:all, :conditions => {:parent_id => nil } )
    # end

    # Only allow a list of trusted parameters through.
    def post_category_params
      params.require(:post_category).permit(:title, :parent_id)
    end
end
