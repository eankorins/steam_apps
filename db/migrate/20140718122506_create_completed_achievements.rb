class CreateCompletedAchievements < ActiveRecord::Migration
  def change
    create_table :completed_achievements do |t|
    	t.integer :user_id
    	t.integer :achievement_id
    	
      t.timestamps
    end
  end
end
