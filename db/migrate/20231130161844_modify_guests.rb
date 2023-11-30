class ModifyGuests < ActiveRecord::Migration[7.1]
  def up
    change_column :guests, :type, :string, comment: "Guest can be a regular or working guest."
    add_reference :guests, :invited_by, type: :uuid, foreign_key: { to_table: :users }, null: false
    add_reference :guests, :approved_by, type: :uuid, foreign_key: { to_table: :users }, null: true
    add_column :guests, :valid_from, :datetime, comment: 'The Guest is valid from this Date and Time.'
    add_column :guests, :valid_to, :datetime, comment: 'The Guest is valid till this Date and Time.'
  end

  def down
    remove_column :guests, :valid_to, :datetime
    remove_column :guests, :valid_from, :datetime
    remove_reference :guests, :approved_by, foreign_key: { to_table: :users }
    remove_reference :guests, :invited_by, foreign_key: { to_table: :users }
    change_column :guests, :type, :integer, using: 'type::integer', default: 0,
                  comment: "Guest can be a regular or working guest."
  end
end
