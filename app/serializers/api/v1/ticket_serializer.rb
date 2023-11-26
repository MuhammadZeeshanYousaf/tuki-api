class Api::V1::TicketSerializer < ActiveModel::Serializer
  attributes :id, :description, :price
  has_one :event
end
