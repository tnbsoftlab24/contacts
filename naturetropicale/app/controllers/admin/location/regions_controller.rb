class Admin::Location::RegionsController < Admin::DashboardController
  before_action :set_admin_location_region, only: [:show, :edit, :update, :destroy]

  # GET /admin/location/regions
  # GET /admin/location/regions.json
  def index
    @admin_location_regions = Admin::Location::Region.search(filter_params).order(:name)
  end

  # GET /admin/location/regions/1
  # GET /admin/location/regions/1.json
  def show
  end

  # GET /admin/location/regions/new
  def new
    @admin_location_region = Admin::Location::Region.new
  end

  # GET /admin/location/regions/1/edit
  def edit
  end

  # POST /admin/location/regions
  # POST /admin/location/regions.json
  def create
    @admin_location_region = Admin::Location::Region.new(admin_location_region_params)

    respond_to do |format|
      if @admin_location_region.save
        format.html { redirect_to @admin_location_region, notice: 'Region was successfully created.' }
        format.json { render :show, status: :created, location: @admin_location_region }
      else
        format.html { render :new }
        format.json { render json: @admin_location_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/location/regions/1
  # PATCH/PUT /admin/location/regions/1.json
  def update
    respond_to do |format|
      if @admin_location_region.update(admin_location_region_params)
        format.html { redirect_to @admin_location_region, notice: 'Region was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_location_region }
      else
        format.html { render :edit }
        format.json { render json: @admin_location_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/location/regions/1
  # DELETE /admin/location/regions/1.json
  def destroy
    @admin_location_region.destroy
    respond_to do |format|
      format.html { redirect_to admin_location_regions_url, notice: 'Region was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_location_region
      @admin_location_region = Admin::Location::Region.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_location_region_params
      params.require(:admin_location_region).permit(:name, :province_id)
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
