class CreateApartments < ActiveRecord::Migration[7.1]
  def change
    create_table :apartments, id: :uuid do |t|
      t.string :number
      t.string :license_plate
      t.references :community, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
