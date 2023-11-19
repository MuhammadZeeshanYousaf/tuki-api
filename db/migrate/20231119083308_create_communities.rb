class CreateCommunities < ActiveRecord::Migration[7.1]
  def change
    create_table :communities do |t|
      t.string :name

      t.timestamps
    end

    add_reference :users, :community, index: true
  end
end
