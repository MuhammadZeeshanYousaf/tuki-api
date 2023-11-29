class ChangeAnnouncementType < ActiveRecord::Migration[7.1]
  def up
    change_column :announcements, :type, :integer, using: 'type::integer', default: 0,
                  comment: 'An enum, it could be warning or alert.'
    add_column :announcements, :topic, :string
  end

  def down
    change_column :announcements, :type, :string,
                  comment: "Type of the announcement, it could be Owner, Member, Admin or Guest."
    remove_column :announcements, :topic, :string
  end
end
