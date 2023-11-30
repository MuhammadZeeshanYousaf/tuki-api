class DropInvitations < ActiveRecord::Migration[7.1]
  def up
    drop_table :invitations
  end

  def down
    # This migration is irreversible. Trying to rollback will raise an IrreversibleMigration error.
    raise ActiveRecord::IrreversibleMigration
  end
end
