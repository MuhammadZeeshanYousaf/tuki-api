class AddStartEndDateToEvent < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :started_at, :start_time
    rename_column :events, :ended_at, :end_time

    remove_column :events, :expired_at, :datetime
    add_columns :events, :start_date, :end_date, type: :date, comment: 'Date on the event start and end.'
  end
end
