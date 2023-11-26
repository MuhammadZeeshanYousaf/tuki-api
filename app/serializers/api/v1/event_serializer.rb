class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :seats, :started_at, :ended_at, :expired_at
  has_one :community
end
