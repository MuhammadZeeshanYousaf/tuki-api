class RenameTypeColumn < ActiveRecord::Migration[7.1]
  def change
    # Rename column to resolve conflict: the column 'type' is reserved for storing the class in case of inheritance.
    rename_column :announcements, :type, :group
  end
end
