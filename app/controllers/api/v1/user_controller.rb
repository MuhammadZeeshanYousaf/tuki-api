class Api::V1::Users::UserController < Api::V1::BaseController

  def info
    render json: current_api_v1_user, serializer: Api::V1::UserSerializer
  end

end
