class AddPurposeToGuest < ActiveRecord::Migration[7.1]
  def change
    add_column :guests, :purpose, :string
  end
end
