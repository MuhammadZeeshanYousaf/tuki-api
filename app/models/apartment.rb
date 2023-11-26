class Apartment < ApplicationRecord
  belongs_to :community
  has_many :owners

  validates :license_plate, :number, presence: true, uniqueness: true
end
