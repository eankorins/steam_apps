class AddAchievementCounterCache < ActiveRecord::Migration
  def change
  	add_column :games, :achievements_count, :integer, default: 0
  end
end
