# frozen_string_literal: true

class AdminAbility < ApplicationAbility

  def initialize(user)
    super

    can :manage, :admin_dashboard
    can :create, Event
    can :read, Event
    can :destroy, Event, community: user.community
    can :update, Event, community: user.community
    can :create, Owner
    can :read, Owner

  end

end
