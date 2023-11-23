class CreateTenants < ActiveRecord::Migration[7.1]
  def change
    create_table :tenants, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :owner, null: false, foreign_key: true, type: :uuid
      t.references :tenantship, type: :uuid, foreign_key: { to_table: :tenants }, null: true

      t.timestamps
    end
  end
end
