# frozen_string_literal: true

class Api::V1::OwnerAbility < Api::V1::MemberAbility
  # frozen_string_literal: true

    def initialize(user)
      super
      owner = user.owner
      raise('Owner doest not exist!') if owner.blank?
      apartment = owner.apartment
      raise('Apartment does not exist!') if apartment.blank?

      can :manage, :dashboard
      can :read, Apartment, user: { owner: { apartment: apartment } }
      can :manage, Owner, user: { owner: owner }
    end

end
