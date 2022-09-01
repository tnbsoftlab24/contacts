class Admin::Location::VillesController < Admin::DashboardController
  before_action :set_admin_location_ville, only: [:show, :edit, :update, :destroy]

  # GET /admin/location/villes
  # GET /admin/location/villes.json
  def index
    @admin_location_villes = Admin::Location::Ville.search(filter_params).order(:name)
  end

  # GET /admin/location/villes/1
  # GET /admin/location/villes/1.json
  def show
  end

  # GET /admin/location/villes/new
  def new
    @admin_location_ville = Admin::Location::Ville.new
  end

  # GET /admin/location/villes/1/edit
  def edit
  end

  # POST /admin/location/villes
  # POST /admin/location/villes.json
  def create
    @admin_location_ville = Admin::Location::Ville.new(admin_location_ville_params)

    respond_to do |format|
      if @admin_location_ville.save
        format.html { redirect_to @admin_location_ville, notice: 'Ville creé avec succès.' }
        format.json { render :show, status: :created, location: @admin_location_ville }
      else
        format.html { render :new }
        format.json { render json: @admin_location_ville.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/location/villes/1
  # PATCH/PUT /admin/location/villes/1.json
  def update
    respond_to do |format|
      if @admin_location_ville.update(admin_location_ville_params)
        format.html { redirect_to @admin_location_ville, notice: 'Ville mise à jour avec succès.' }
        format.json { render :show, status: :ok, location: @admin_location_ville }
      else
        format.html { render :edit }
        format.json { render json: @admin_location_ville.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/location/villes/1
  # DELETE /admin/location/villes/1.json
  def destroy
    @admin_location_ville.destroy
    respond_to do |format|
      format.html { redirect_to admin_location_villes_url, notice: 'Ville supprimé avec succès.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_location_ville
      @admin_location_ville = Admin::Location::Ville.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_location_ville_params
      params.require(:admin_location_ville).permit(:name, :region_id)
    end

    def filter_params
      if params[:name].blank?
        {}
      else
        {
          name: params[:name]
        } 
      end
    end
end
