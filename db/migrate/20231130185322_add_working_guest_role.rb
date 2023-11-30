class AddWorkingGuestRole < ActiveRecord::Migration[7.1]
  def up
    Role.create!(name: 'Working Guest', key: :working_guest)
  end

  def down
    Role.destroy_by key: :working_guest
  end
end
