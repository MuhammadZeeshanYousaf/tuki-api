class TimeSlot < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy

  enum day: {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6
  }

  validates :start_time, presence: true, uniqueness: { scope: [ :event_id, :day ] }
  validates :end_time, presence: true, uniqueness: { scope: [ :event_id, :day ] }
  validate :start_and_end_time_uniqueness

  before_create :set_available_seats

  private

    def start_and_end_time_uniqueness
      if start_time == end_time
        errors.add(:base, 'Start time and end time must be unique')
      end
    end

    def set_available_seats
      self.available_seats = self.event.seats
    end
end
