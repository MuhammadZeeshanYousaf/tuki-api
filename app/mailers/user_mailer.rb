class UserMailer < ApplicationMailer
  def add_user
    params.freeze
    @user = params[:user]
    @password = params[:password]

    if @user.role_guest?
      @guest = @user.guest
    elsif @user.role_working_guest?
      @guest = @user.working_guest
    end

    mail(to: email_address_with_name(@user.email, @user.name), subject: "Invitation to join #{APP_NAME}!")
  end
end
