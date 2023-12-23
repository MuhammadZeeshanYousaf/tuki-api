class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: %i[ show update destroy ]

  # GET /events
  def index
    authorize! :read, Event
    @events = @community.events

    render json: @events, each_serializer: EventSerializer
  end

  # GET /events/upcoming
  def upcoming
    authorize! :upcoming, Event
    @events = @community.events.upcoming_by_date

    render json: @events, each_serializer: EventSerializer
  end

  # GET /events/:id/available_slots
  def available_slots
    # return event with available slots
  end

  # GET /events/1
  def show
    authorize! :read, Event
    render json: @event, serializer: EventSerializer
  end

  # POST /events
  def create
    authorize! :create, Event
    @event = @community.events.new(event_params)

    if @event.save
      render json: @event, serializer: EventSerializer,
             status: :created, location: api_v1_event_path(@event)
    else
      render json: { error: full_error(@event) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize! :update, @event

    if @event.update(event_params.except(:event_type))
      render json: @event, serializer: EventSerializer
    else
      render json: { error: full_error(@event) }, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    authorize! :destroy, @event
    @event.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = @community.events.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_type, :name, :description, :seats, :start_date, :end_date, :charges, :allocated_guard_id, :banner,
                                    time_slots_attributes: [:id, :day, :start_time, :end_time])
    end
end
