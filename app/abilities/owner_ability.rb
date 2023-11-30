# frozen_string_literal: true

class OwnerAbility < ApplicationAbility

    def initialize(user)
      super
      owner = user.owner
      raise('Owner does not exist!') if owner.blank?
      apartment = owner.apartment
      raise('Apartment does not exist!') if apartment.blank?

      can :manage, :owner_dashboard
      can :read, Apartment, user: { owner: { apartment: apartment } }
      can :manage, Owner, account: { owner: owner }
      can :manage, :co_owners
      can :show, Owner, ownership: owner
      can :eliminate, Owner, ownership: owner
      can :manage, Tenant, owner: owner
      can :eliminate, Tenant, owner: owner
      can :manage, Guest, invited_by: user
      can :manage, WorkingGuest, invited_by: user
    end

end
