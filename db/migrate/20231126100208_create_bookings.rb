class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings, id: :uuid do |t|
      t.references :bookable, polymorphic: true, null: false, type: :uuid
      t.references :booked_by, null: false, type: :uuid, foreign_key: { to_table: :users },
                   comment: 'Custom column name which references to users table.'
      t.float :amount_paid, comment: 'How much the amount deducted from user account for the booking.'

      t.timestamps
    end
  end
end
