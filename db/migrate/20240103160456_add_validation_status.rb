class AddValidationStatus < ActiveRecord::Migration[7.1]
  def change
    # enum of validation status
    [:attendees, :guests].each do |table|
      add_column table, :validation_status, :integer, default: 0
    end
  end
end
