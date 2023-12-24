# frozen_string_literal: true

class GuardAbility < ApplicationAbility

  def initialize(user)
    super

    can :upcoming, Event, community: @community
    can :read, Event
    can :manage, :guard_dashboard
    can :manage, Validation

  end

end
