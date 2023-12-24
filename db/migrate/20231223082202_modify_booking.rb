class ModifyBooking < ActiveRecord::Migration[7.1]
  def change
    rename_column :bookings, :booked_by_id, :booker_id
    add_column :bookings, :total_attendees, :integer, comment: 'Total attendees of the event including booker.'
    add_column :bookings, :payment_status, :integer, default: 0, comment: 'Enum of payment status.'
    add_column :bookings, :transaction_id, :string, comment: 'Transaction id from webpay.'
    add_index :bookings, :transaction_id, unique: true
    add_column :bookings, :order_id, :string, comment: 'Order id from webpay.'
    remove_reference :bookings, :bookable, polymorphic: true, index: true
    add_reference :bookings, :time_slot, null: false, foreign_key: true, index: true, type: :uuid
  end
end
