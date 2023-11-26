class CreateSportCourts < ActiveRecord::Migration[7.1]
  def change
    create_table :sport_courts, id: :uuid do |t|
      t.belongs_to :community, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :sport, comment: 'Sport / Game name which is offered in the sport_court.'
      t.float :rent

      t.timestamps
    end
  end
end
