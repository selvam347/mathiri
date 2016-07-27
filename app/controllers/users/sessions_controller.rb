class Users::SessionsController < Devise::SessionsController
 before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
     user = User.find_by(email: params[:email])
     if user && user.valid_password?(params[:password])
       auth = user.create_auth_token(token: SecureRandom.uuid)
       render json: {status: 200, token: auth.token}
     else
       render json: {status: 400}
     end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
