class Booking < ApplicationRecord
  belongs_to :bookable, polymorphic: true
  belongs_to :booked_by, class_name: 'User'
end
