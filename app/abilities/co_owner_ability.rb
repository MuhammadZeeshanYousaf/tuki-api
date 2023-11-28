# frozen_string_literal: true

class CoOwnerAbility < OwnerAbility
  # frozen_string_literal: true

  def initialize(user)
    super
    cannot :create, Owner
  end

end
