class ChangeIdColumn < ActiveRecord::Migration
  def change
  	rename_column :players, :steam_id, :account_id
  end
end
