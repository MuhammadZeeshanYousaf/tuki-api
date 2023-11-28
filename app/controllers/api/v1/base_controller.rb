class Api::V1::BaseController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :authenticate_super_admin!, if: -> { current_api_v1_user.role_super_admin? }
  before_action :set_community, unless: -> { current_api_v1_user.role_super_admin? || current_api_v1_user.role_guard? }


  protected

  def authenticate_super_admin!
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                                 Rails.application.credentials.devise[:jwt_secret_key]).first
        user_id = jwt_payload['sub']

        user = User.find(user_id.to_s)
        unless current_api_v1_user&.id&.eql?(user.id) && current_api_v1_user&.role_super_admin?
          raise 'Unathorized super admin!'
        end
      rescue => e
        render json: { error: e.message }, status: :unauthorized
      end
  end

  def current_ability
    begin
      case current_api_v1_user&.role_key
      when :member.to_s
        @current_ability = Api::V1::MemberAbility.new(current_api_v1_user)
      when :admin.to_s
        @current_ability = Api::V1::AdminAbility.new(current_api_v1_user)
      when :guard.to_s
        @current_ability = Api::V1::GuardAbility.new(current_api_v1_user)
      when :super_admin.to_s
        @current_ability = Api::V1::SuperAdminAbility.new(current_api_v1_user)
      when :guest.to_s
        @current_ability = Api::V1::GuardAbility.new(current_api_v1_user)
      when :owner.to_s
        @current_ability = Api::V1::OwnerAbility.new(current_api_v1_user)
      else
        @current_ability = ApplicationAbility.new(current_api_v1_user)
      end
    rescue => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def set_community
    @community = current_api_v1_user.community
    render(json: { error: 'Community does not exist!' }, status: :forbidden) if @community.blank?
  end


end
