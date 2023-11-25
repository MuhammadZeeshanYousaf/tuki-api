class Api::V1::OwnersController < Api::V1::BaseController
  before_action :set_owner, only: %i[ show update destroy ]

  # GET /owners
  def index
    @owners = Owner.where apartment_id: params[:apartment_id]

    render json: @owners, each_serializer: Api::V1::OwnerSerializer
  end

  # GET /owners/1
  def show
    render json: @owner, serializer: Api::V1::OwnerSerializer
  end

  # POST /owners
  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      render json: @owner, serializer: Api::V1::OwnerSerializer, status: :created, location: api_v1_owner_path(@owner)
    else
      render json: { error: full_error(@owner) }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/1
  def update
    if @owner.update(owner_params)
      render json: @owner, serializer: Api::V1::OwnerSerializer
    else
      render json: { error: full_error(@owner) }, status: :unprocessable_entity
    end
  end

  # DELETE /owners/1
  def destroy
    @owner.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find_by!(id: params[:id], apartment_id: params[:apartment_id])
    end

    # Only allow a list of trusted parameters through.
    def owner_params
      params.require(:owner).permit(:user_id, :apartment_id, :ownership_id)
    end
end
