class Api::V1::GuestsController < Api::V1::BaseController
  before_action :set_guest, only: %i[ show destroy ]

  # GET /guests
  def index
    authorize! :index, Guest

    render json: current_api_v1_user.guest_invitations, each_serializer: GuestSerializer
  end

  # GET /guests/1
  def show
    authorize! :show, @guest

    render json: @guest, serializer: GuestSerializer
  end

  # POST /guests
  def create
    authorize! :create, Guest

    ActiveRecord::Base.transaction do
      account = @community.users.create! account_params.merge(role: Role.find_by_key(:guest))
      @guest = current_api_v1_user.guest_invitations.create! guest_params.merge(user: account)
    end

    render json: @guest, serializer: GuestSerializer, status: :created, location: api_v1_guest_path(@guest)
  rescue ActiveRecord::RecordInvalid => e
      # If an exception occurs, the transaction will be rolled back, and no changes will be saved
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /guests/1
  def destroy
    authorize! :destroy, @guest

    @guest.user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id])
    end

    def account_params
      params.require(:guest).permit(:first_name, :last_name, :nationality, :national_id, :contact, :birthdate, :email, :password, :avatar)
    end

    # Only allow a list of trusted parameters through.
    def guest_params
      params.require(:guest).permit :valid_from, :valid_to
    end
end
