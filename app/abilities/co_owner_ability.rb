# frozen_string_literal: true

class CoOwnerAbility < ApplicationAbility
  # frozen_string_literal: true

  def initialize(user)
    super

    can :manage, :co_owner_dashboard
    can :manage, Guest, invited_by: user
    can :manage, WorkingGuest, invited_by: user
  end

end
