class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations, id: :uuid do |t|
      t.references :reservable, polymorphic: true, null: false, type: :uuid
      t.integer :reserved_hours, comment: 'Number of hours for an amenity is reserved. ( No more than 24)'
      t.float :rent_paid

      t.timestamps
    end
  end
end
