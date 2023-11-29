class CreateEliminatedAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :eliminated_accounts, id: :uuid do |t|
      t.references :eliminated, polymorphic: true, null: false, type: :uuid
      t.string :reason
      t.text :message

      t.timestamps
    end
  end
end
