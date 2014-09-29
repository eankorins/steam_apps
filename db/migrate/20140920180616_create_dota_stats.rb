class CreateDotaStats < ActiveRecord::Migration
  def change
    create_table :dota_stats do |t|
      t.string :player_id
      t.string :winning_kda
      t.string :losing_kda
      t.string :string
      t.string :avg_kda
      t.integer :radiant_matches
      t.integer :dire_matches
      t.string :most_played_hero
      t.string :most_played_mode
      t.string :most_played_with
      t.integer :wins
      t.integer :losses
    end
    add_index :dota_stats, :player_id
  end
end
