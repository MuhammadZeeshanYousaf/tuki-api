# frozen_string_literal: true

class AdminAbility < ApplicationAbility

  def initialize(user)
    super

    can :manage, :admin_dashboard
    can :manage, Event, community: @community
    can :create, Owner
    can :index, Owner
    can :show, Owner, account: { community: @community }
    can :destroy, Owner do |owner|
      owner.account.community_id == @community.id && (owner.account.role_co_owner? || owner.account.role_owner?)
    end
    can :eliminate, Owner, account: { community: @community }
    can :read, :co_owners
    can :create, :co_owners
    can :create, Announcement
    can :announced_to, Announcement, user: { community: @community }
    can :manage, :guards
    can :manage, Apartment, community: @community

  end

end
