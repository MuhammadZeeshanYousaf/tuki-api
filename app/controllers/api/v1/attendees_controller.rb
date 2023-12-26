class Api::V1::AttendeesController < Api::V1::BaseController
  skip_before_action :authenticate_api_v1_user!, :authenticate_super_admin!, :set_community, only: :attendee_qr, if: -> { request.get? }
  before_action :set_attendee

  # GET|POST /attendee_qr/:id
  def attendee_qr
    if request.post?
      authorize! :attendee_qr, :validate
      render json: @attendee.booking

    elsif request.get?
      # @Todo - SHOW Booking basic details with html rendering
      render plain: '<Booking QR Details Hidden>'
    end
  end


  private

    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

end
