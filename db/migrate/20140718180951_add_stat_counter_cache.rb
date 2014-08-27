class AddStatCounterCache < ActiveRecord::Migration
  def change
  	add_column :games, :stats_count, :integer, :default => 0
  	add_column :games, :playedgames_count, :integer, :default => 0
  	add_column :players, :playedgames_count, :integer, :default => 0
  	add_column :players, :total_time, :integer, :default => 0
  	add_index :achievements, :name, unique:true
  	add_index :stats, :name, unique:true
  	add_index :playedgames, :player_id
  end
end
