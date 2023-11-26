class Reservation < ApplicationRecord
  belongs_to :reservable, polymorphic: true

  validates :reserved_hours, presence: true, numericality: { less_than_or_equal_to:  24 }
end
