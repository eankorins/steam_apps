class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.integer :game_id
      t.integer :defaultvalue
      t.string :displayname
      t.integer :hidden
      t.string :description
      t.string :icon
      t.string :icongray

      t.timestamps
    end
  end
end
