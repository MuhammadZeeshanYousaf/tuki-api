class BookingSerializer < ActiveModel::Serializer
  attributes :id, :amount_paid
  has_one :bookable
  has_one :booker
  has_many :attendees
end
