class CreateValidations < ActiveRecord::Migration[7.1]
  def change
    create_table :validations, id: :uuid do |t|
      t.belongs_to :booking, null: false, foreign_key: true, type: :uuid
      t.references :validated_by, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.integer :status, default: 0, comment: 'e.g., Is it valid or not.'
      t.text :note, comment: 'If someone misbehaves or for any reason, the note will be recorded.'

      t.timestamps
    end
  end
end
