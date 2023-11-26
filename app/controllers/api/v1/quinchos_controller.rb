class Api::V1::QuinchosController < Api::V1::BaseController
  before_action :set_quincho, only: %i[ show update destroy ]

  # GET /quinchos
  def index
    @quinchos = Quincho.all

    render json: @quinchos
  end

  # GET /quinchos/1
  def show
    render json: @quincho
  end

  # POST /quinchos
  def create
    @quincho = Quincho.new(quincho_params)

    if @quincho.save
      render json: @quincho, status: :created, location: @quincho
    else
      render json: @quincho.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quinchos/1
  def update
    if @quincho.update(quincho_params)
      render json: @quincho
    else
      render json: @quincho.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quinchos/1
  def destroy
    @quincho.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quincho
      @quincho = Quincho.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quincho_params
      params.require(:quincho).permit(:community_id, :name, :description, :is_grilled)
    end
end
