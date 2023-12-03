class Api::V1::UserController < Api::V1::BaseController
  before_action :set_user

  def show
    authorize! :show, @user
    render json: @user, serializer: UserSerializer
  end

  def update
    authorize! :update, @user

    if @user.update(user_params)
      render json: @user, serializer: UserSerializer
    else
      render json: { error: full_error(@user) }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_api_v1_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact, :birthdate, :national_id)
  end

end
