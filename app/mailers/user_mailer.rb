class UserMailer < ApplicationMailer
  def add_user
    params.freeze
    @user = params[:user]
    @password = params[:password]

    mail(to: email_address_with_name(@user.email, @user.name), subject: "Invitation to join #{APP_NAME}!")
  end
end
