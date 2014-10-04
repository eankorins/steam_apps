class AddDetailedStatsToHeroes < ActiveRecord::Migration
  def change

  	add_column :heroes, :wins, :integer
  	add_column :heroes, :losses, :integer
  	add_column :heroes, :kills, :number
  	add_column :heroes, :assists, :number
  	add_column :heroes, :deaths, :number
  end
end
