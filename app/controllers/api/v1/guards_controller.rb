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

end
