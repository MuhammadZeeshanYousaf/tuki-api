class GuardReferenceToEvent < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :allocated_guard, null: true, index: true, type: :uuid,
                  comment: 'Event can have an allocated guard.'
  end
end
