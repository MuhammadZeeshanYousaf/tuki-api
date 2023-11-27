# frozen_string_literal: true

class Api::V1::AdminAbility < Api::V1::MemberAbility

  def initialize(user)
    super

    can :manage, :admin_dashboard
    can :create, Event

  end

end
