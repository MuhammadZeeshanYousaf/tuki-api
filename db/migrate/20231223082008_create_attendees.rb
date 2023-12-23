class CreateAttendees < ActiveRecord::Migration[7.1]
  def change
    create_table :attendees, id: :uuid do |t|
      t.references :booking, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
    end
  end
end
