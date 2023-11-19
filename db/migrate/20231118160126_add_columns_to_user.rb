class AddColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    add_columns :users, :first_name, :last_name, :contact, :national_id, type: :string
    add_column :users, :birthdate, :date

    add_index :users, :national_id
  end

end
