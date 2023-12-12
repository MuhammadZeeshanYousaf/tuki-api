class Booking < ApplicationRecord
  include QrEncodeable

  belongs_to :bookable, polymorphic: true
  belongs_to :booked_by, class_name: 'User'
end
