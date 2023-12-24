class Attendee < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  alias_attribute :account_id, :user_id

  validates :user_id, uniqueness: { scope: [:booking_id, :user_id] }
end
