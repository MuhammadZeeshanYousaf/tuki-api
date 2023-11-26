# @Todo - Remove the test controller

class Api::V1::MembersController < Api::V1::BaseController

    def show
      puts 'AUTHENTICATED USER:', current_api_v1_user.inspect
      user ||= current_api_v1_user

      render json: {
        message: "If you see this, you're in!",
        user: user
      }
    end

end
