class GuestSerializer < ActiveModel::Serializer
  attributes :id, :valid_from, :valid_to, :purpose, :validation_status
  has_one :user, key: :account
  has_one :invited_by
  has_one :approved_by
end
