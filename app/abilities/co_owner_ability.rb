# frozen_string_literal: true

class CoOwnerAbility < ApplicationAbility
  # frozen_string_literal: true

  def initialize(user)
    super

    cannot :create, Owner
    cannot :destroy, Owner
    can :manage, :co_owner_dashboard
  end

end
