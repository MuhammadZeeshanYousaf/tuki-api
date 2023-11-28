class Api::V1::UserController < Api::V1::BaseController

  def info
    render json: current_api_v1_user, serializer: UserSerializer
  end

end
