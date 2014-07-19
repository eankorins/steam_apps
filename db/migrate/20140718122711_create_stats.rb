class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :game_id
      t.string :name
      t.integer :value
      t.string :displayname

      t.timestamps
    end
  end
end
