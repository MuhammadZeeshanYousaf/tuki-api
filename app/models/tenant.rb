class Tenant < ApplicationRecord
  default_scope { where(tenantship_id: nil) }

  belongs_to :user
  alias_method :account, :user
  belongs_to :owner
  has_one :apartment, through: :owner
  has_many :co_tenants, class_name: 'Tenant', foreign_key: 'tenantship_id'
  belongs_to :tenantship, class_name: 'Tenant', optional: true

  has_one :eliminated_account, as: :eliminated
end
