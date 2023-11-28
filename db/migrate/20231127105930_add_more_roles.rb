class AddMoreRoles < ActiveRecord::Migration[7.1]
  def up
    [
      ['Owner', :owner],
      ['Tenant', :tenant]
    ].each do |r|
      Role.create(name: r.first, key: r.second)
    end
  end

  def down
    Role.destroy_by key: [:owner, :tenant]
  end
end
