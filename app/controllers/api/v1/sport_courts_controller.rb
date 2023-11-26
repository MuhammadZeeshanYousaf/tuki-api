class Api::V1::SportCourtsController < Api::V1::BaseController
  before_action :set_sport_court, only: %i[ show update destroy ]

  # GET /sport_courts
  def index
    @sport_courts = SportCourt.all

    render json: @sport_courts
  end

  # GET /sport_courts/1
  def show
    render json: @sport_court
  end

  # POST /sport_courts
  def create
    @sport_court = SportCourt.new(sport_court_params)

    if @sport_court.save
      render json: @sport_court, status: :created, location: @sport_court
    else
      render json: @sport_court.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sport_courts/1
  def update
    if @sport_court.update(sport_court_params)
      render json: @sport_court
    else
      render json: @sport_court.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sport_courts/1
  def destroy
    @sport_court.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport_court
      @sport_court = SportCourt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sport_court_params
      params.require(:sport_court).permit(:community_id, :name, :sport, :rent)
    end
end
