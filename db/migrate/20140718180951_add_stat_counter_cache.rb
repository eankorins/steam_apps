class AddStatCounterCache < ActiveRecord::Migration
  def change
  	add_column :games, :stats_count, :integer, :default => 0
  	add_index :achievements, :name, unique:true
  	add_index :stats, :name, unique:true
  	add_index :players, :steamid, unique:true
  end
end
