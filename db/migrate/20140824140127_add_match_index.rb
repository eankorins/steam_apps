class AddMatchIndex < ActiveRecord::Migration
  def change
  	add_index :matches, :match_id
  end
end
