class CreateQuinchos < ActiveRecord::Migration[7.1]
  def change
    create_table :quinchos, id: :uuid do |t|
      t.belongs_to :community, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.text :description
      t.boolean :is_grilled, default: false, comment: "Some Barbecue areas (Quinchos) have grills, others don't"

      t.timestamps
    end
  end
end
