class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :player_id
      t.integer :player_slot
      t.integer :hero_id
      t.integer :match_id

      t.timestamps
    end
  end
end
