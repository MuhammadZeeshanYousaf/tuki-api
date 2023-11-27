# frozen_string_literal: true

class Api::V1::OwnerAbility < Api::V1::MemberAbility
  # frozen_string_literal: true

    def initialize(user)
      super
      owner = user.owner
      return render(json: { error: 'Owner does not exist!' }, status: :forbidden) if owner.blank?
      apartment = user.owner.apartment rescue return render(json: { error: 'Apartment does not exist!' }, status: :forbidden)

      can :manage, :dashboard
      can :read, Apartment, user: { owner: { apartment: apartment } }
      can :manage, Owner, user: { owner: owner }
    end

end
