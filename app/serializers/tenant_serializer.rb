class TenantSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user, key: :account
  has_one :eliminated_account
  has_one :owner
  has_one :tenantship

end
