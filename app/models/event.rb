class Event < ApplicationRecord
  belongs_to :community
  has_one :ticket
  has_many :passes
  accepts_nested_attributes_for :passes
  # cannot accept nested attributes for ticket, only works for has_many association

  validates :name, :start_date, :end_date, :start_time, :end_time, :seats, presence: true
end
