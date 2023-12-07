# frozen_string_literal: true

class GuardAbility < ApplicationAbility

  def initialize(user)
    super
    guard_community = user.community

    can :read, Event, community: guard_community
    can :manage, :guard_dashboard

  end

end
