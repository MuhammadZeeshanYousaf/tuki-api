# frozen_string_literal: true

class AdminAbility < ApplicationAbility

  def initialize(user)
    super

    admin_community = user.community

    can :manage, :admin_dashboard
    can :create, Event
    can :read, Event
    can :destroy, Event, community: admin_community
    can :update, Event, community: admin_community
    can :create, Owner
    can :index, Owner
    can :show, Owner, account: { community: admin_community }
    can :destroy, Owner do |owner|
      owner.account.community_id == admin_community.id && (owner.account.role_co_owner? || owner.account.role_owner?)
    end
    can :eliminate, Owner, account: { community: admin_community }
    can :read, :co_owners
    can :create, Announcement
    can :announced_to, Announcement, user: { community: admin_community }
    can :read, User, community: admin_community

  end

end
