class Event < ApplicationRecord
  belongs_to :community
  has_one :ticket
  has_many :passes

  validates :name, :started_at, :ended_at, :seats, presence: true
end
