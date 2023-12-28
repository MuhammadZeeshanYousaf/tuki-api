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
  validate :day_in_range

  default_scope { order(created_at: :desc) }

  before_create :set_available_seats

  def date_of_the_day
    slot_event = self.event
    this_date = slot_event.start_date
    max_days = 30
    day_count = 1

    while this_date != slot_event.end_date.next_day && day_count != max_days do
      if this_date.strftime("%A").downcase.eql? day.downcase
        return this_date
      else
        this_date = this_date.next_day
      end
      day_count += 1
    end
    false
  end

  private

    def start_and_end_time_uniqueness
      if start_time == end_time
        errors.add(:base, 'Start time and end time must be unique')
      end
    end

    def day_in_range
      unless date_of_the_day.present?
        errors.add(:day, 'must exist in the event date range!')
      end
    end

    def set_available_seats
      self.available_seats = self.event.seats
    end
end
