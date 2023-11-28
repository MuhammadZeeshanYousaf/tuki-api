class BookingSerializer < ActiveModel::Serializer
  attributes :id, :amount_paid
  has_one :bookable
  has_one :booked_by
end
