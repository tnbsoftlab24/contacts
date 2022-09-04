class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session
  helper_method :sort_column, :sort_direction
  helper_method :browser_time_zone
  before_action :set_time_zone, if: :user_signed_in?
  include JobsHelper
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def set_time_zone
    Time.zone = current_user.time_zone
  end

  def browser_time_zone
    browser_tz = ActiveSupport::TimeZone.find_tzinfo(cookies[:timezone])
    ActiveSupport::TimeZone.all.find{ |zone| zone.tzinfo == browser_tz } || Time.zone
  rescue TZInfo::UnknownTimezone, TZInfo::InvalidTimezoneIdentifier
    Time.zone
    # 
  end

  def approved
    if !current_user.profile.approved? 
      if !request.xhr? && !Regexp.new("^/(profiles/#{current_user.profile.id}/edit|profile-validation)").match?(request.path_info)
        flash[:error] = "Votre compte est en cours de validation"
        redirect_to "/profile-validation" unless request.fullpath == "/profile-validation"
      end
    end
  end

  private

    # def user_not_authorized
    #   flash[:error] = "You are not authorized to perform this action."
    #   redirect_to(request.referrer || root_path)
    # end

    def sort_column
      Job.column_names.include?(params[:sort]) ? params[:sort] : "poste"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

   
     

end
