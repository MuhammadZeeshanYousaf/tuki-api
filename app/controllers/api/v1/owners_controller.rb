class Api::V1::OwnersController < Api::V1::BaseController
  before_action :set_owner, only: %i[ dashboard co_owners show update destroy ]

  # GET /owner/dashboard
  def dashboard
    authorize! :manage, :dashboard

    co_owners_count = @owner.co_owners.count
    tenants_count = @owner.tenants.count
    bookings_count = @owner.bookings.count
    community_events = ::ActiveModel::SerializableResource.new(@community.events, each_serializer: Api::V1::EventSerializer).serializable_hash[:events]

    render json: {
      co_owners: co_owners_count,
      tenants: tenants_count,
      bookings: bookings_count,
      events: community_events
    }
  end

  # GET /owner/co_owners
  def co_owners
    render json: @owner.co_owners, each_serializer: Api::V1::OwnerSerializer, root: 'co_owners'
  end

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
    authorize! :create, Owner
    ActiveRecord::Base.transaction do
      if owner_params.has_key?(:apartment_id)
        @apartment = Apartment.find(owner_params[:apartment_id])
      else
        @apartment = Apartment.find_or_initialize_by(apartment_params.merge(community: @community))
        return render(json: { error: full_error(@apartment) }, status: :unprocessable_entity) unless @apartment.save
      end

      owner_account = @community.users.new account_params.merge(role: Role.find_by_key(:owner), community: @community)
      return render(json: { error: full_error(owner_account) }, status: :unprocessable_entity) unless owner_account.save

      # if ownership_id provided then co_owner will be created
      @owner = @apartment.owners.new(owner_params.merge(user: owner_account))

      if @owner.save
        render json: @owner, serializer: Api::V1::OwnerSerializer, status: :created, location: api_v1_owner_path(@owner)
      else
        render json: { error: full_error(@owner) }, status: :unprocessable_entity
      end
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
      @owner = current_api_v1_user.owner
    end

    def set_apartment
      @apartment = @owner.apartment
    end

    # Only allow a list of trusted parameters through.
    def owner_params
      # if ownership_id provided then co_owner will be created
      params.require(:owner).permit( :apartment_id, :ownership_id) || {}
    end

    def account_params
      params.require(:owner).permit( :first_name, :last_name, :national_id, :contact, :birthdate, :email, :password)
    end

    def apartment_params
      params.require(:apartment).permit( :number, :license_plate)
    end
end
