class AddParticipantPlayerIndex < ActiveRecord::Migration
  def change
  	add_index :participants, :player_id
  end
end
