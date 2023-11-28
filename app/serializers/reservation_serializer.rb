class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :reserved_hours, :rent_paid
  has_one :reservable
end
