class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: %i[ show update destroy ]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = @community.events.new(event_params)

    if @event.save
      Ticket.create!(ticket_params.merge(event: @event))
      @event.passes.create!(pass_params)

      render json: @event, serializer: Api::V1::EventSerializer,
             status: :created, location: api_v1_event_path(@event)
    else
      render json: { error: full_error(@event) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :seats, :start_date, :end_date, :start_time, :end_time)
    end

    def ticket_params
      params.require(:ticket).permit(:price)
    end

    def pass_params
      params.require(:passes).permit! if params.require(:passes).is_a? Array
    end

end
