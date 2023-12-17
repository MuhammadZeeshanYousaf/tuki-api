class AddColumnsToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :event_type, :integer, default: 0
    add_column :events, :charges, :float, default: 0
  end
end
