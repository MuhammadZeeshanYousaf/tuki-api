class Tenant < ApplicationRecord
  belongs_to :user
  belongs_to :owner

  has_many :co_tenants, class_name: 'Tenant', foreign_key: 'tenantship_id'
  belongs_to :tenantship, class_name: 'Tenant', optional: true
end
