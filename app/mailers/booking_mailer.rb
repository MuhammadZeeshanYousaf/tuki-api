class BookingMailer < ApplicationMailer

  def booking_details
    @attendee = params[:attendee]
    @user = @attendee.user

    # @Todo - extract booking details

    mail(to: email_address_with_name(@user.email, @user.name), subject: "Booking invitation - #{APP_NAME}!")
  end
end
