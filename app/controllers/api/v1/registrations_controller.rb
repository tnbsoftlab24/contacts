class Api::V1::RegistrationsController < Devise::RegistrationsController
     # sign up
     def create
      user = User.new user_params
      if user.save
        render json: {
          message: "Sign Up Successfully",
          is_success: true,
          token: "null",
          data: {user: user}
        }, status: :ok
      else
        render json: {
          message: "Sign Up Failded",
          is_success: false,
          token: "null",
          data: {}
        }, status: :unprocessable_entity
      end
    end

    def forgot
      user = User.find_by_email(forgot_params)
      if user.present?
       user.send_reset_password_instructions
       render(
            json: "{ \"result\": \"Email already exists\"}",
            status: 201
          )
      else
        render(
            json: "{ \"error\": \"Not found\"}",
            status: 404
          )
      end
    end
  
    def reset
      token = params[:token].to_s
  
      if params[:email].blank?
        return render json: {message: 'Token not present'}
      end
  
      user = User.find_by(reset_password_token: token)
  
      if user.present? && user.password_token_valid?
        if user.reset_password!(params[:password])
          render json: {status: 'ok'}, status: :ok
        else
          render json: {message: user.errors.full_messages}, status: :unprocessable_entity
        end
      else
        render json: {message:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
      end
    end
  
  
    private
    def user_params
      params.permit(:email, :password, :password_confirmation,:role,:terms_conditions,:time_zone)
    end
    def forgot_params
      params.require(:email)
    end
  
    def ensure_params_exist
      return if params[:user].present?
      render json: {
          message: "Missing Params",
          is_success: false,
          data: {}
        }, status: :bad_request
    end
end
   