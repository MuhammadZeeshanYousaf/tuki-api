class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_api_v1_user!

  protected

  def configure_permitted_parameters
    # Permit the parameters along with the other
    # example parameters permits
    #
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.for(:sign_up) do |u|
    #   u.permit({ roles: [] }, :name,:email, :password, :password_confirmation)
    # end
    # devise_parameter_sanitizer.for(:account_update) do |u|
    #   u.permit({ roles: [] }, :email, :password, :password_confirmation, :avatar,:current_password, :about,:user, :name)
    # end
  end

  def full_error(obj)
    obj&.errors&.full_messages&.to_sentence
  end

  def authenticate_super_admin!
    begin
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                               Rails.application.credentials.devise[:jwt_secret_key]).first
      user_id = jwt_payload['sub']

      user = User.find(user_id.to_s)
      unless current_api_v1_user&.id&.eql?(user.id)
        raise 'Unathorized super admin!'
      end
    rescue => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

end
