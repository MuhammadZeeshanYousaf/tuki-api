class Api::V1::OwnersController < Api::V1::BaseController
  before_action :set_owner, only: %i[ show destroy eliminate ]

  # For Owner accessible only
  # GET /owner/dashboard
  def dashboard
    authorize! :manage, :owner_dashboard

    @owner = current_api_v1_user.owner
    co_owners_count = @owner.co_owners.count
    tenants_count = @owner.tenants.count
    bookings_count = @owner.bookings.count
    community_events = ::ActiveModel::SerializableResource.new(@community.events.upcoming_by_date, each_serializer: EventSerializer).serializable_hash[:events]

    render json: {
      co_owners: co_owners_count,
      tenants: tenants_count,
      bookings: bookings_count,
      events: community_events
    }
  end

  # GET /owners
  def index
    authorize! :index, Owner

    render json: @community.owners, each_serializer: OwnerSerializer
  end

  # GET /owners/1
  def show
    authorize! :show, @owner

    render json: @owner, serializer: OwnerSerializer
  end

  # POST /owners
  def create
    authorize! :create, Owner

    ActiveRecord::Base.transaction do
      # Find or Create apartment
      if apartment_params[:apartment_id].present?
        @apartment = Apartment.find(apartment_params[:apartment_id])
      else
        @apartment = Apartment.find_or_initialize_by(apartment_params.merge(community: @community))
        return render(json: { error: full_error(@apartment) }, status: :unprocessable_entity) unless @apartment.save
      end

      # Create login account for Owner
      account = @community.users.new account_params.merge(role: Role.find_by_key(:owner))
      return render(json: { error: full_error(account) }, status: :unprocessable_entity) unless account.save

      # Create Apartment owner
      @owner = @apartment.owners.new(user: account)

      # Response
      if @owner.save
        render json: @owner, serializer: OwnerSerializer,
               status: :created, location: api_v1_owner_path(@owner)
      else
        render json: { error: full_error(@owner) }, status: :unprocessable_entity
      end
    end
  end

  # DELETE /owners/1
  def destroy
    authorize! :destroy, @owner

    ActiveRecord::Base.transaction do
      if @owner.co_owners.present?
        co_owner_account_ids = @owner.co_owners.pluck :user_id
        User.destroy_by id: co_owner_account_ids
      end
      @owner.account.destroy!
    end
  end

  # DELETE /owners/:id/eliminate
  def eliminate
    authorize! :eliminate, @owner
    eliminated_account = EliminatedAccount.find_or_initialize_by eliminate_params.merge(eliminated: @owner)

    if eliminated_account.save
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    def account_params
      params.require(:owner).permit(:first_name, :last_name, :email, :national_id, :contact, :birthdate, :avatar)
    end

    def eliminate_params
      params.require(:owner).permit(:reason, :message)
    end

    def apartment_params
      # Either :apartment_id should be present OR :number, :license_plate must be present
      params.require(:apartment).permit(:number, :license_plate, :apartment_id)
    end
end
