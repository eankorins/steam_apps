class AddDetailedStatsToHeroes < ActiveRecord::Migration
  def change

  	add_column :heroes, :wins, :integer
  	add_column :heroes, :losses, :integer
  	add_column :heroes, :kills, :decimal
  	add_column :heroes, :assists, :decimal
  	add_column :heroes, :deaths, :decimal
  end
end
