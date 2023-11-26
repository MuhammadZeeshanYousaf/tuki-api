class Event < ApplicationRecord
  belongs_to :community

  validates :name, :started_at, :ended_at, :seats, presence: true
end
