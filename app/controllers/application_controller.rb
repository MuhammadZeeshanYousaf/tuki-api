class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :unauthorized
  end

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

  def current_ability
    begin
      case current_api_v1_user&.role_key
      when :member.to_s
        @current_ability = ApplicationAbility.new(current_api_v1_user)
      when :admin.to_s
        @current_ability = AdminAbility.new(current_api_v1_user)
      when :guard.to_s
        @current_ability = GuardAbility.new(current_api_v1_user)
      when :super_admin.to_s
        @current_ability = SuperAdminAbility.new(current_api_v1_user)
      when :guest.to_s
        @current_ability = GuestAbility.new(current_api_v1_user)
      when :owner.to_s
        @current_ability = OwnerAbility.new(current_api_v1_user)
      else
        @current_ability = ApplicationAbility.new(current_api_v1_user)
      end
    rescue => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

end
