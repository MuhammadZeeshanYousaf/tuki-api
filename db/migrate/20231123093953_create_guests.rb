class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid,
                   comment: 'A temporary member account will be created for guest.'
      t.integer :type, default: 0, comment: 'Guest can be a regular or working guest.'

      t.timestamps
    end
  end
end
