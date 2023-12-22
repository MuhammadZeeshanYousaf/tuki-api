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

  def password
    authorize! :update, @user

    if @user.valid_password? password_params[:current_password]
      if password_params[:password] == password_params[:password_confirmation]
        return render(json: { message: 'Password is used before, choose a new password!' }, status: :forbidden) if password_params[:password] == password_params[:current_password]

        if @user.update password: password_params[:password]
          render json: { message: 'Password updated successfully' }
        else
          render json: { error: full_error(@user) }, status: :unprocessable_entity
        end
      else
        render json: { message: 'Password confirmation is invalid!' }, status: :forbidden
      end
    else
      render json: { message: 'Invalid current password!' }, status: :forbidden
    end
  end


  private

  def set_user
    @user = current_api_v1_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact, :birthdate)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end
