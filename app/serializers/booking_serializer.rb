class BookingSerializer < ActiveModel::Serializer
  attributes :id, :amount_paid
  has_one :time_slot
  has_one :booker
  has_many :attendees
end
