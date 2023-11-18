class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    render json: {
      message: 'You are logged in.',
      user: current_api_v1_user
    }, status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_api_v1_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Failed to logout.' }, status: :unauthorized
  end
end
