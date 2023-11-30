class Api::V1::WorkingGuestsController < Api::V1::BaseController
  # before_action :set_working_guest, only: %i[ show update destroy ]

  def create
    authorize! :create, WorkingGuest

    ActiveRecord::Base.transaction do
      account = @community.users.create! account_params.merge(role: Role.find_by_key(:working_guest))
      @working_guest = current_api_v1_user.working_guest_invitations.create! working_guest_params.merge(user: account)
    end

    render json: @working_guest, serializer: GuestSerializer, root: 'working_guest',
           status: :created, location: api_v1_working_guest_path(@working_guest)
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  private

    def set_working_guest
      WorkingGuest.find(params[:id])
    end

    def working_guest_params
      params.require(:working_guest).permit :valid_from, :valid_to
    end

    def account_params
      params.require(:working_guest).permit(:first_name, :last_name, :national_id, :contact, :birthdate, :email, :password)
    end

end
