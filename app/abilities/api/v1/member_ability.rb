# frozen_string_literal: true

class Api::V1::MemberAbility < ApplicationAbility

  def initialize(user)
    # define common abilities here

    can :read, :user
    cannot :manage, :admin
  end

end
