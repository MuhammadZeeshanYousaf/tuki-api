class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events, id: :uuid do |t|
      t.belongs_to :community, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.text :description
      t.integer :seats, comment: 'Available seats'
      t.datetime :started_at, comment: 'When to start'
      t.datetime :ended_at, comment: 'When to end'
      t.datetime :expired_at, comment: 'If event happens for multiple days, then expiry date and time.'

      t.timestamps
    end
  end
end
