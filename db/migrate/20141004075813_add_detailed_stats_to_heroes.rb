class AddDetailedStatsToHeroes < ActiveRecord::Migration
  def change

  	add_column :heroes, :wins, :integer
  	add_column :heroes, :losses, :integer
  	add_column :heroes, :kda, :integer
  end
end
