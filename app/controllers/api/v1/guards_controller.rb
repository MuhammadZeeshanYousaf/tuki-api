class Api::V1::GuardsController < Api::V1::BaseController

  def dashboard
    authorize! :manage, :guard_dashboard

    upcoming_events = @community.events.upcoming_by_date
    events_count = upcoming_events.count
    guard_validations_count = current_api_v1_user.validations.count

    render json: {
      events_count: events_count,
      validations_count: guard_validations_count,
      events: upcoming_events
    }
  end

  # GET /guards
  def index
    authorize! :index, :guards
    guards = Role.guard.first&.users&.where(community: @community)

    render json: guards, each_serializer: UserSerializer, root: :guards
  end

  # GET /guards/:id
  def show
    authorize! :show, :guards
    guard = Role.guard.first&.users&.find_by(id: params[:id], community: @community)

    if guard
      render json: guard, serializer: UserSerializer, root: :guard
    else
      render json: { error: "Guard not found!" }, status: :not_found
    end
  end

  # POST /guards
  def create
    authorize! :create, :guards

    ActiveRecord::Base.transaction do
      # Find or Create apartment
      if apartment_params[:apartment_id].present?
        @apartment = Apartment.find(apartment_params[:apartment_id])
      else
        @apartment = Apartment.find_or_initialize_by(apartment_params.merge(community: @community))
        return render(json: { error: full_error(@apartment) }, status: :unprocessable_entity) unless @apartment.save
      end

      # Create account for Guard
      account = @community.users.new account_params.merge(role: Role.find_by_key(:guard))
      return render(json: { error: full_error(account) }, status: :unprocessable_entity) unless account.save

      # Response
      if account.save
        render json: account, serializer: UserSerializer, root: :guard,
               status: :created, location: api_v1_guard_path(account)
      else
        render json: { error: full_error(account) }, status: :unprocessable_entity
      end
    end
  end

  # GET /guard/validations
  def validations
    authorize! :read, Validation
    guard_validations = current_api_v1_user.validations

    render json: guard_validations, each_serializer: ValidationSerializer
  end


  private

  def account_params
    params.require(:guard).permit(:first_name, :last_name, :national_id, :contact, :birthdate, :email, :password, :avatar)
  end

  def apartment_params
    # Either :apartment_id should be present OR :number, :license_plate must be present
    params.require(:apartment).permit(:number, :license_plate, :apartment_id)
  end

end
