class AddCoRoles < ActiveRecord::Migration[7.1]
  def up
    [
      ['Co-owner', :co_owner],
      ['Co-tenant', :co_tenant]
    ].each do |r|
      Role.create(name: r.first, key: r.second)
    end
  end

  def down
    Role.destroy_by key: [:co_owner, :co_tenant]
  end
end
