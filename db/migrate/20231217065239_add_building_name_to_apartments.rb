class AddBuildingNameToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :building_name, :string
  end
end
