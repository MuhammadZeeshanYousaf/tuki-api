class Booking < ApplicationRecord
  include QrEncodeable

  belongs_to :bookable, polymorphic: true
  belongs_to :booker, class_name: 'User'
  has_many :attendees, dependent: :destroy
end
