class GuestSerializer < ActiveModel::Serializer
  attributes :id, :type
  has_one :user, key: :account
end
