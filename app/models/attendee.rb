class Attendee < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  default_scope { order(created_at: :desc) }
end
