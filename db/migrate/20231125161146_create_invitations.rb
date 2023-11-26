class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid, comment: 'The user who invited the guest.'
      t.belongs_to :guest, foreign_key: true, type: :uuid, comment: 'The guest profile if the invitation is accepted by guest.'
      t.string :email, comment: 'The email on which the invitation is sent.'
      t.integer :status, default: 0, comment: 'Guest invitation is pending / accepted / rejected'

      t.timestamps
    end
  end
end
