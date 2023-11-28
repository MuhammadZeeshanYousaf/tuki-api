class OwnerSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user, key: :account
  has_one :apartment
  has_one :ownership
end
