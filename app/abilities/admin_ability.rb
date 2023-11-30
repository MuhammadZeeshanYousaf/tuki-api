# frozen_string_literal: true

class AdminAbility < ApplicationAbility

  def initialize(user)
    super

    community = user.community

    can :manage, :admin_dashboard
    can :create, Event
    can :read, Event
    can :destroy, Event, community: community
    can :update, Event, community: community
    can :create, Owner
    can :index, Owner
    can :show, Owner, account: { community: community }
    can :destroy, Owner do |owner|
      owner.account.community_id == community.id && (owner.account.role_co_owner? || owner.account.role_owner?)
    end
    can :eliminate, Owner, account: { community: community }
    can :read, :co_owners
    can :create, Announcement
    can :announced_to, Announcement, user: { community: community }

  end

end
