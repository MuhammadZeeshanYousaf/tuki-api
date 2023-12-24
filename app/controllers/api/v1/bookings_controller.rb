class Api::V1::BookingsController < Api::V1::BaseController
  before_action :set_booking, only: %i[ show update destroy ]

  # GET /bookings
  def index
    authorize! :index, Booking
    @bookings = current_api_v1_user.bookings

    render json: @bookings
  end

  # @todo - remove it later
  # GET /bookings/time_slot/:time_slot_id
  def time_slot
    authorize! :time_slot, Booking
    # after showing available slots
    # show details of the bookable time_slot with charges
  end

  # POST|PUT /bookings/:id/checkout
  def checkout
    authorize! :checkout, Booking
    @booking = current_api_v1_user.bookings.find(params[:id])

    # save all attendees
    if @booking.update(checkout_params)
      render json: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # GET /bookings/1
  def show
    authorize! :show, @booking
    render json: @booking
  end

  # POST /bookings
  def create
    @booking = current_api_v1_user.bookings.new(booking_params)

    if @booking.save
      render json: @booking, status: :created
    else
      render json: { error: full_error(@booking) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(booking_params)
      render json: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:total_attendees, :time_slot_id)
    end

    def checkout_params
      params.require(:booking).permit(attendees_attributes: [:user_id])
    end
end
