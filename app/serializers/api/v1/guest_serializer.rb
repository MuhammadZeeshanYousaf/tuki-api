class Api::V1::GuestSerializer < ActiveModel::Serializer
  attributes :id, :type
  has_one :user, key: :account
end
