class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets, id: :uuid do |t|
      t.belongs_to :event, null: false, foreign_key: true, type: :uuid
      t.text :description
      t.float :price, comment: 'Price could be in dollars.'

      t.timestamps
    end
  end
end
