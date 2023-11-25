# frozen_string_literal: true

class Api::V1::AdminAbility < Api::V1::BaseAbility

  def initialize(user)
    super

    can :manage, :admin_dashboard

  end

end
