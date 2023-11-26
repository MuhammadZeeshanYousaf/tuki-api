class Ticket < ApplicationRecord
  belongs_to :event

  validates :price, presence: true, numericality: { greater_than: 0 }
end
