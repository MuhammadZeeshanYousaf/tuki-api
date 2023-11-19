class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true, index: true
      t.references :role, type: :uuid, null: false, foreign_key: true, index: true

      # It could also be like following:
      # t.uuid :user_id, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
