class BookingSerializer < ActiveModel::Serializer
  attributes :id, :total_attendees, :payment_status, :amount_paid, :created_at
  has_one :time_slot
  has_one :booker
  has_many :attendees

end
