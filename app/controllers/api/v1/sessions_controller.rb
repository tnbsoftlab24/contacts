class Api::V1::SessionsController <  ApplicationController

    before_action :authorize_request, except: :create
    # POST /session/create
    def create
      user = User.find_by_email(params[:email])
      valid_password = User.find_by_email(user_params[:email]).valid_password?(user_params[:password])
      if  valid_password
        render json: payload(user)
      else
        render json: {:message => "Invalid Email or Password"}, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.permit(:email, :password)
    end

    def payload(user)
      return nil unless user and user.id
      {
        token: JsonWebToken.encode({user_id: user.id}),
        is_success: true,
        data: {user: {id: user.id, email: user.email, is_new: user.is_new, is_validate: user.is_validate, confirmed_at: user.confirmed_at}}
       
      }
    end
end

