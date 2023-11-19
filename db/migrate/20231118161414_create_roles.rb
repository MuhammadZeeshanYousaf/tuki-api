class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name
      t.integer :key, default: 0

      t.timestamps
    end

    add_index :roles, :key, unique: true
  end
end
