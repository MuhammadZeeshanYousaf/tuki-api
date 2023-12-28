class BookingMailer < ApplicationMailer

  def booking_details
    @attendee = params[:attendee]
    @user = @attendee.user
    @booking = @attendee.booking
    @booker = @booking.booker
    @time_slot = @booking.time_slot
    @event = @time_slot.event

    mail(to: email_address_with_name(@user.email, @user.name), subject: "Booking invitation - #{APP_NAME}!")
  end
end
