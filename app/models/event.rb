class Event < ApplicationRecord
  has_one_attached :banner

  belongs_to :community
  has_many :time_slots, dependent: :destroy
  has_many :bookings, through: :time_slots
  has_many :attendees, through: :bookings
  belongs_to :allocated_guard, class_name: 'User', optional: true # event can have an allocated guard
  accepts_nested_attributes_for :time_slots
  enum :event_type, { other: 0, sports: 1, barbq: 2, party: 3 }

  validates :name, :start_date, :end_date, :seats, presence: true

  # comparing with current Time zone set in application.rb
  # scope :upcoming_by_time, -> {
  #   current_time = Time.current.strftime('%H:%M:%S').split(':').map(&:to_i)
  #   where("EXTRACT(HOUR FROM end_time) >= ? AND EXTRACT(MINUTE FROM end_time) >= ? AND EXTRACT(SECOND FROM end_time) >= ?", *current_time)
  # }
  scope :upcoming_by_date, -> {
    where("DATE(start_date) <= :current_date AND DATE(end_date) >= :current_date", { current_date: Date.current })
  }

  # @Todo - scope not working
  # scope :upcoming, -> {
  #   current_time = Time.current.strftime('%H:%M:%S').split(':').map(&:to_i)
  #   where(
  #     "DATE(start_date) <= :current_date AND DATE(end_date) >= :current_date AND " \
  #       "EXTRACT(HOUR FROM end_time) >= :hour AND EXTRACT(MINUTE FROM end_time) >= :minute AND EXTRACT(SECOND FROM end_time) >= :second",
  #     { current_date: Date.current, hour: current_time[0], minute: current_time[1], second: current_time[2] }
  #   )
  # }


end
