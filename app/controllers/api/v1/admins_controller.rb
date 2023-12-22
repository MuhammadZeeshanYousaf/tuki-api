class Api::V1::AdminsController < Api::V1::BaseController
  before_action :set_admin_user

  def dashboard
    authorize! :manage, :admin_dashboard

    owners_count = @community.owners.count
    guests_count = 0
    bookings_count = 0
    community_events = ::ActiveModel::SerializableResource.new(@community.events, each_serializer: EventSerializer).serializable_hash[:events]

    render json: {
      owners: owners_count,
      guests: guests_count,
      bookings: bookings_count,
      events: community_events
    }
  end

  private

  def set_admin_user
    @admin = current_api_v1_user
  end

end
