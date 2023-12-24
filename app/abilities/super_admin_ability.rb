# frozen_string_literal: true

class SuperAdminAbility < ApplicationAbility

  def initialize(user)
    super

    can :manage, Community
  end

end
