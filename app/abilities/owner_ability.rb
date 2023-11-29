# frozen_string_literal: true

class OwnerAbility < ApplicationAbility
  # frozen_string_literal: true

    def initialize(user)
      super
      owner = user.owner
      raise('Owner doest not exist!') if owner.blank?
      apartment = owner.apartment
      raise('Apartment does not exist!') if apartment.blank?

      can :manage, :owner_dashboard
      can :read, Apartment, user: { owner: { apartment: apartment } }
      can :manage, Owner, user: { owner: owner }
      can :destroy, Owner
      can :read, :co_owners
    end

end
