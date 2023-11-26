class Quincho < ApplicationRecord
  belongs_to :community
  has_many :bookings, as: :reservable

  validates :name, presence: true
end
