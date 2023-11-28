class Api::V1::OwnersController < Api::V1::BaseController
  before_action :set_owner, only: %i[ dashboard co_owners show update destroy ]

  # GET /owner/dashboard
  def dashboard
    authorize! :manage, :dashboard

    co_owners_count = @owner.co_owners.count
    tenants_count = @owner.tenants.count
    bookings_count = @owner.bookings.count
    community_events = ::ActiveModel::SerializableResource.new(@community.events, each_serializer: EventSerializer).serializable_hash[:events]

    render json: {
      co_owners: co_owners_count,
      tenants: tenants_count,
      bookings: bookings_count,
      events: community_events
    }
  end

  # GET /owner/co_owners
  def co_owners
    render json: @owner.co_owners, each_serializer: OwnerSerializer, root: 'co_owners'
  end

  # GET /owners
  def index
    authorize! :read, Owner
    if request.path.include?('co_owner')
      @co_owners = @community.co_owners
      render json: @co_owners, each_serializer: OwnerSerializer, root: 'co_owners'

    else
      @owners = @community.owners
      render json: @owners, each_serializer: OwnerSerializer
    end
  end

  # GET /owners/1
  def show
    render json: @owner, serializer: OwnerSerializer
  end

  # POST /owners
  def create
    authorize! :create, Owner

    ActiveRecord::Base.transaction do
      if request.path.include?('co_owner')
        owner = @community.owners.find_by! id: x_owner_params[:ownership_id]
        @apartment = owner.apartment
        role = Role.find_by_key(:co_owner)
        alias :location_path :api_v1_co_owner_path

      else
        if x_owner_params[:apartment_id].present?
          @apartment = Apartment.find(x_owner_params[:apartment_id])
        else
          @apartment = Apartment.find_or_initialize_by(apartment_params.merge(community: @community))
          return render(json: { error: full_error(@apartment) }, status: :unprocessable_entity) unless @apartment.save
        end

        role = Role.find_by_key(:owner)
        alias :location_path :api_v1_owner_path
      end

      account = @community.users.new account_params.merge(role: role)
      return render(json: { error: full_error(account) }, status: :unprocessable_entity) unless account.save

      # if ownership_id provided then co_owner will be created
      @x_owner = @apartment.owners.new(x_owner_params.merge(user: account))

      if @x_owner.save
        render json: @x_owner, serializer: OwnerSerializer, root: role.co_owner? ? 'co_owner' : 'owner',
               status: :created, location: location_path(@x_owner)
      else
        render json: { error: full_error(@x_owner) }, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /owners/1
  def update
    if @owner.update(x_owner_params)
      render json: @owner, serializer: OwnerSerializer
    else
      render json: { error: full_error(@owner) }, status: :unprocessable_entity
    end
  end

  # DELETE /owners/1
  def destroy
    authorize! :destroy, @owner
    @owner.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = User.find(params[:id])
    end

    def set_apartment
      @apartment = @owner.apartment
    end

    # Only allow a list of trusted parameters through.
    def x_owner_params
      if params[:co_owner].present?
        params.require(:co_owner).permit( :apartment_id, :ownership_id)
      elsif params[:owner].present?
        params.require(:owner).permit( :apartment_id)
      else Hash.new
      end
    end

    def account_params
      params.require(params[:co_owner].present? ? :co_owner : :owner)
            .permit( :first_name, :last_name, :national_id, :contact, :birthdate, :email, :password)
    end

    def apartment_params
      params.require(:apartment).permit( :number, :license_plate)
    end
end
