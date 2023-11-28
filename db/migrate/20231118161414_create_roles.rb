class CreateRoles < ActiveRecord::Migration[7.1]
  def up
    create_table :roles, id: :uuid do |t|
      t.string :name
      t.integer :key, default: 0

      t.timestamps
    end
    add_index :roles, :key, unique: true

    # Date migration
    [
      ['Member', :member],
      ['Guard', :guard],
      ['Admin', :admin],
      ['Super Admin', :super_admin],
      ['Guest', :guest]
    ].each do |r|
      Role.create(name: r.first, key: r.second)
    end

  end

  def down
    Role.destroy_by key: [:member, :guard, :admin, :super_admin, :guest]
    remove_index :roles, :key, unique: true
    drop_table :roles
  end
end
