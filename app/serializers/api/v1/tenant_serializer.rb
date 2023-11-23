class Api::V1::TenantSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :owner
  has_one :tenantship
end
