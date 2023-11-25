# @Todo - Remove the test controller

class Api::V1::MembersController < Api::V1::BaseController

    def show
      puts 'AUTHENTICATED USER:', current_api_v1_user.inspect
      user = get_user_from_token
      user ||= current_api_v1_user

      render json: {
        message: "If you see this, you're in!",
        user: user
      }
    end

    private

    def get_user_from_token
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                               Rails.application.credentials.devise[:jwt_secret_key]).first
      user_id = jwt_payload['sub']
      User.find(user_id.to_s)
    end

end
