class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots, id: :uuid do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.integer :day, default: 0
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end

    remove_column :events, :start_time, :datetime
    remove_column :events, :end_time, :datetime
  end
end
