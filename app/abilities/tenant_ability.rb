# frozen_string_literal: true

class TenantAbility < ApplicationAbility
  # frozen_string_literal: true

  def initialize(user)
    super
    tenant = user.tenant
    raise('Tenant does not exist!') if tenant.blank?
    owner = tenant.owner
    raise('Owner does not exist!') if owner.blank?
    apartment = owner.apartment
    raise('Apartment does not exist!') if apartment.blank?

    # can :create, Tenant # co-tenant
  end

end
