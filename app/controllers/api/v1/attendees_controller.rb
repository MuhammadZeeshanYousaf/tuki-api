class Api::V1::AttendeesController < Api::V1::BaseController
  skip_before_action :authenticate_api_v1_user!, only: :attendee_qr
  before_action :set_attendee, if: -> { request.get? }

  # GET|POST /attendee_qr/:id
  def attendee_qr
    if request.post?
      authenticate_api_v1_user!
      authorize! :attendee_qr, :validate

      if event_params[:id].present?
        @event = @community.events.upcoming_by_date.find_by! event_params
        @attendee = @event.attendees.find params[:id]
      else
        set_attendee
      end
      render json: @attendee.booking

    elsif request.get?
      # @Todo - SHOW Booking basic details with html rendering
      if @attendee.present?
        html = "<html><head></head><body><h4>Booking is valid.</h4></body></html>".html_safe
      else
        html = "<html><head></head><body><h4>Booking is invalid!</h4></body></html>".html_safe
      end
      render html: html, :content_type => 'text/html'
    end
  end


  private

    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:id)
    end

end
