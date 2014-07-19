class AddIndexToGames < ActiveRecord::Migration
  def change
  	add_index :games, :appid, unique:true
  	
  end
end
