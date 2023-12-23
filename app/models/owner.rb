class Owner < ApplicationRecord
  default_scope { where(ownership_id: nil) }

  belongs_to :user
  alias_method :account, :user
  belongs_to :apartment
  has_many :tenants, -> { where(tenantship: nil) }
  has_many :co_tenants, through: :tenants
  # has_many :bookings, as: :bookable

  has_many :co_owners, class_name: "Owner", foreign_key: "ownership_id"
  belongs_to :ownership, class_name: 'Owner', optional: true
  has_one :eliminated_account, as: :eliminated, dependent: :destroy

end
