class Booking < ApplicationRecord
  include QrEncodeable

  belongs_to :time_slot
  belongs_to :booker, class_name: 'User'
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees

  enum :payment_status, { pending: 0, paid: 1, canceled: 2 }
end
