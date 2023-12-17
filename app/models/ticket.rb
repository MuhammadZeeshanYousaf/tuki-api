# charges column is added to event, no need for ticket for the time being
# @todo - remove it in the last phase

class Ticket < ApplicationRecord
  # belongs_to :event
  # has_many :bookings, as: :bookable
  #
  # validates :price, presence: true, numericality: { greater_than: 0 }
end
