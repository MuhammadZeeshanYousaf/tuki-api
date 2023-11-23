class Api::V1::OwnerSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :apartment
  has_one :ownership
end
