class AddDetailsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :winner, :string
    add_column :matches, :first_blood, :integer
    add_column :matches, :season, :integer
    add_column :matches, :duration, :integer
    add_column :matches, :human_players, :integer
    add_column :matches, :positive_votes, :integer
    add_column :matches, :negative_votes, :integer
    add_column :matches, :cluster, :integer
    add_column :matches, :mode, :string
    add_column :matches, :league_id, :integer
    add_column :matches, :radiant_tower_status, :integer
    add_column :matches, :dire_tower_status, :integer
    add_column :matches, :radiant_barracks_status, :integer
    add_column :matches, :dire_barracks_status, :integer
  end
end
