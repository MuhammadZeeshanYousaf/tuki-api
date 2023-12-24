class AddAvailableSeatsToTimeSlot < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots, :available_seats, :integer
  end
end
