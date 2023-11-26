class CreateAnnouncements < ActiveRecord::Migration[7.1]
  def change
    create_table :announcements, id: :uuid do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true, type: :uuid,
                   comment: 'The User of role Admin or Super Admin, or could be Owner who has access to.'
      t.string :type, comment: 'Type of the announcement, it could be Owner, Member, Admin or Guest.'
      t.uuid :announced_to, comment: 'If a specific user is announced_to then reference of that user.'

      t.timestamps
    end
  end
end
