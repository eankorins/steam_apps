class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :cost
      t.string :played

      t.timestamps
    end
  end
end
