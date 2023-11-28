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
    can :destroy, User, community: user.community, role: Role.find_by!(key: :co_owner)
    can :destroy, User, community: user.community, role: Role.find_by!(key: :owner)

  end

end
