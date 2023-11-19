class Apartment < ApplicationRecord
  belongs_to :community

  validates :license_plate, :number, presence: true, uniqueness: true
end
