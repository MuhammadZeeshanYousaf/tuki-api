class SportCourt < ApplicationRecord
  belongs_to :community
  has_many :bookings, as: :reservable

  validates :name, :sport, :rent, presence: true
end
