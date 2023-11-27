class Pass < ApplicationRecord
  belongs_to :event
  has_many :bookings, as: :bookable
end
