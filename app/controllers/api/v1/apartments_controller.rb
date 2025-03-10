class Api::V1::ApartmentsController < Api::V1::BaseController
  before_action :set_apartment, only: %i[ show update destroy ]

  # GET /apartments
  def index
    authorize! :index, Apartment
    @apartments = @community.apartments

    render json: @apartments, each_serializer: ApartmentSerializer
  end

  # GET /apartments/:id
  def show
    render json: @apartment, serializer: ApartmentSerializer
  end

  # POST /apartments
  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.community_id = params[:community_id]

    if @apartment.save
      render json: @apartment, serializer: ApartmentSerializer,
             status: :created, location: api_v1_apartment_path(@apartment)
    else
      render json: { error: full_error(@apartment) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /apartments/:id
  def update
    if @apartment.update(apartment_params)
      render json: @apartment, serializer: ApartmentSerializer
    else
      render json: { error: full_error(@apartment) }, status: :unprocessable_entity
    end
  end

  # DELETE /apartments/:id
  def destroy
    @apartment.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def apartment_params
      params.require(:apartment).permit(:number, :license_plate)
    end
end
