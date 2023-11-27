class CreatePasses < ActiveRecord::Migration[7.1]
  def change
    create_table :passes, id: :uuid do |t|
      t.belongs_to :event, null: false, foreign_key: true, type: :uuid
      t.integer :valid_days, comment: 'Pass validity days.'
      t.float :price, comment: 'Price of the pass, possibly in dollars.'

      t.timestamps
    end
  end
end
