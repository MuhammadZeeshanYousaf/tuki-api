class Api::V1::BaseController < Api::V1::BaseController
  before_action :authenticate_api_v1_user!
  before_action :authenticate_super_admin!, if: -> { current_api_v1_user.role?(:super_admin) }


  protected

  def authenticate_super_admin!
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                                 Rails.application.credentials.devise[:jwt_secret_key]).first
        user_id = jwt_payload['sub']

        user = User.find(user_id.to_s)
        unless current_api_v1_user&.id&.eql?(user.id) && current_api_v1_user&.role?(:super_admin)
          raise 'Unathorized super admin!'
        end
      rescue => e
        render json: { error: e.message }, status: :unauthorized
      end
  end


end
