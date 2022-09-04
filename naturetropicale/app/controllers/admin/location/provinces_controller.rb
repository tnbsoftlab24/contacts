class Admin::Location::ProvincesController < Admin::DashboardController
  before_action :set_admin_location_province, only: [:show, :edit, :update, :destroy]

  # GET /admin/location/provinces
  # GET /admin/location/provinces.json
  def index
    @admin_location_provinces = Admin::Location::Province.search(filter_params).order(:name)
  end

  # GET /admin/location/provinces/1
  # GET /admin/location/provinces/1.json
  def show
  end

  # GET /admin/location/provinces/new
  def new
    @admin_location_province = Admin::Location::Province.new
  end

  # GET /admin/location/provinces/1/edit
  def edit
  end

  # POST /admin/location/provinces
  # POST /admin/location/provinces.json
  def create
    @admin_location_province = Admin::Location::Province.new(admin_location_province_params)

    respond_to do |format|
      if @admin_location_province.save
        format.html { redirect_to @admin_location_province, notice: 'Province was successfully created.' }
        format.json { render :show, status: :created, location: @admin_location_province }
      else
        format.html { render :new }
        format.json { render json: @admin_location_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/location/provinces/1
  # PATCH/PUT /admin/location/provinces/1.json
  def update
    respond_to do |format|
      if @admin_location_province.update(admin_location_province_params)
        format.html { redirect_to @admin_location_province, notice: 'Province was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_location_province }
      else
        format.html { render :edit }
        format.json { render json: @admin_location_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/location/provinces/1
  # DELETE /admin/location/provinces/1.json
  def destroy
    @admin_location_province.destroy
    respond_to do |format|
      format.html { redirect_to admin_location_provinces_url, notice: 'Province was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_location_province
      @admin_location_province = Admin::Location::Province.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_location_province_params
      params.require(:admin_location_province).permit(:name)
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
