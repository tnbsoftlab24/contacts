class Admin::JobCategoriesController < ApplicationController
  before_action :set_admin_job_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/job_categories
  # GET /admin/job_categories.json
  def index
    @admin_job_categories = Admin::JobCategory.all
  end

  # GET /admin/job_categories/1
  # GET /admin/job_categories/1.json
  def show
  end

  def all_children2(level=0)
    children_array = []
    level +=1
    #must use "all" otherwise ActiveRecord returns a relationship, not the array itself
    self.children.all.each do |child|
      children_array << "&nbsp;" * level + category.title
      children_array << child.all_children2(level)
    end
    #must flatten otherwise we get an array of arrays. Note last action is returned by default
    children_array = children_array.flatten
  end

  # GET /admin/job_categories/new
  def new
    @admin_job_category = Admin::JobCategory.new
  end

  # GET /admin/job_categories/1/edit
  def edit
  end

  # POST /admin/job_categories
  # POST /admin/job_categories.json
  def create
    @admin_job_category = Admin::JobCategory.new(admin_job_category_params)

    respond_to do |format|
      if @admin_job_category.save
        format.html { redirect_to @admin_job_category, notice: 'Job creé avec succès.' }
        format.json { render :show, status: :created, location: @admin_job_category }
      else
        format.html { render :new }
        format.json { render json: @admin_job_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/job_categories/1
  # PATCH/PUT /admin/job_categories/1.json
  def update
    respond_to do |format|
      if @admin_job_category.update(admin_job_category_params)
        format.html { redirect_to @admin_job_category, notice: 'Categorie de Job mise à jour avec succès.' }
        format.json { render :show, status: :ok, location: @admin_job_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_job_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/job_categories/1
  # DELETE /admin/job_categories/1.json
  def destroy
    @admin_job_category.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: ' Categorie de Job supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_job_category
      @admin_job_category = Admin::JobCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_job_category_params
      params.require(:admin_job_category).permit(:title, :amount, :parent_id, :amount_employee)
    end
end
