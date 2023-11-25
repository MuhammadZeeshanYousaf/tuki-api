class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

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

end
