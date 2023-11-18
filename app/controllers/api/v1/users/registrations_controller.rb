class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed(resource.errors.full_messages.to_sentence)
  end

  def register_success
    render json: {
      message: 'Signed up successfully.',
      user: current_api_v1_user
    }, status: :ok
  end

  def register_failed(err)
    render json: { error: err }, status: :unprocessable_entity
  end
end
