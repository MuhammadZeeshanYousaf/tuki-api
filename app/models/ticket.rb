class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, as: :bookable

  validates :price, presence: true, numericality: { greater_than: 0 }
end
