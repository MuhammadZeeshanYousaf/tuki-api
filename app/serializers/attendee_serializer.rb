class AttendeeSerializer < ActiveModel::Serializer
  has_one :user, key: :account
end
