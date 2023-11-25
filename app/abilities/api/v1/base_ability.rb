# frozen_string_literal: true

class Api::V1::BaseAbility < ApplicationAbility

  def initialize(user)
    # define common abilities here

    can :read, :user
    cannot :manage, :admin
  end

end
