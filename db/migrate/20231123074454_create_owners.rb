class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :apartment, null: false, foreign_key: true, type: :uuid
      t.references :ownership, type: :uuid, foreign_key: { to_table: :owners }, null: true

      t.timestamps
    end
  end
end
