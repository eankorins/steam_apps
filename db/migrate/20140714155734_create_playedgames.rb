class CreatePlayedgames < ActiveRecord::Migration
  def change
    create_table :playedgames do |t|
      t.integer :player_id
      t.integer :game_id
      t.float :playedtime

      t.timestamps
    end
  end
end
