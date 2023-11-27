class AddMoreRoles < ActiveRecord::Migration[7.1]
  def change
    [
      ['Owner', :owner],
      ['Tenant', :tenant]
    ].each do |r|
      Role.create(name: r.first, key: r.second)
    end
  end
end
