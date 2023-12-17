class Api::V1::ValidationsController < Api::V1::BaseController
  before_action :set_validation, only: %i[ show update destroy ]

  # GET /validations
  def index
    authorize! :index, Validation
    @guard_validations = current_api_v1_user.validations

    render json: @guard_validations, each_serializer: ValidationSerializer
  end

  # GET /validations/1
  def show
    render json: @validation
  end

  # POST /validations
  def create
    @validation = Validation.new(validation_params)

    if @validation.save
      render json: @validation, status: :created, location: @validation
    else
      render json: @validation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /validations/1
  def update
    if @validation.update(validation_params)
      render json: @validation
    else
      render json: @validation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /validations/1
  def destroy
    @validation.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_validation
      @validation = Validation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def validation_params
      params.require(:validation).permit(:booking_id, :validated_by_id, :status, :note)
    end
end
