class Api::V1::GuardsController < Api::V1::BaseController

  def dashboard
    authorize! :manage, :guard_dashboard

    events_count = @community.events.upcoming_by_date.count
    guard_validations = current_api_v1_user.validations
    guard_validations_count = guard_validations.count

    render json: {
      events_count: events_count,
      validations_count: guard_validations_count,
      validations: guard_validations
    }
  end

  # GET /guards
  def index
    authorize! :index, User
    guards = Role.guard.first&.users&.where(community: @community)

    render json: guards, each_serializer: UserSerializer, root: :guards
  end

  # GET /guards/:id
  def show
    authorize! :show, User
    guard = Role.guard.first&.users&.find_by(id: params[:id], community: @community)

    if guard
      render json: guard, serializer: UserSerializer, root: :guard
    else
      render json: { error: "Guard not found!" }, status: :not_found
    end
  end

end
