class Admin::UsersController < Admin::DashboardController
  layout 'admin'
  before_action only: [:destroy]

  def index
    # @profiles = Profile.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
    @users_confirmed = User.where.not(confirmed_at: nil).search(params[:search]).paginate(:per_page => 20, :page => params[:confirmed_page])
    @users_unconfirmed = User.where(confirmed_at: nil).search(params[:search]).paginate(:per_page => 20, :page => params[:unconfirmed_page])
    # @profiles = Profile.all
  end

  def update_users_roles
    @profile = Profile.find(params[:id])
    if @profile.user.update_attributes(role: params[:role])
      flash[:notice] = "Le role a ete mis à jour avec succès"
      redirect_to request.referrer
    else
      flash[:notice] = "Une erreur s'est produite"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = 'utilisateur supprimé avec succès'
      redirect_to request.referrer
    else
      flash[:error] = "Une erreur s'est produite"
      redirect_to request.referrer
    end
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end
end
