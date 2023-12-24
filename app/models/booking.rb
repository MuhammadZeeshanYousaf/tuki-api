class Booking < ApplicationRecord
  include QrEncodeable

  belongs_to :time_slot
  belongs_to :booker, class_name: 'User'
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees
  enum :payment_status, { unpaid: 0, in_process: 1, paid: 2, canceled: 3 }
  after_update :in_process!, if: :transaction_id_changed?

  def update_transaction(resp)
    if in_process? && resp['amount'].present? && resp['status'].eql?('AUTHORIZED')
      ActiveRecord::Base.transaction do
        event_slot = time_slot
        remaining_seats = event_slot.available_seats - attendees.count
        update(amount_paid: resp['amount'], payment_status: :paid)
        event_slot.update(available_seats: remaining_seats)
      end
    end
  end

end
