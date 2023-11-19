class CreateCommunities < ActiveRecord::Migration[7.1]
  def change
    create_table :communities, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    add_reference :users, :community, type: :uuid, index: true
  end
end
