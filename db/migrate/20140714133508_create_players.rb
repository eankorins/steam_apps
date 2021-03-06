class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false, force: true do |t|
      t.string :steam_id, null: false
      t.string :name
      t.string :real_name
      t.string :clan_id
      t.string :country_code
      t.string :state_code
      t.datetime :profile_created_at
      t.string :access_state
      t.boolean :configured
      t.string :status
      t.datetime :last_login
      t.string :profile_url
      t.string :small_avatar
      t.string :medium_avatar
      t.string :large_avatar
      t.boolean :commentable
      t.integer :current_game_id
      t.string :current_game_title
      t.string :current_game_server_ip

      t.timestamps
    end
    
    add_index :players, ["steam_id"], name: "index_players_on_steam_id", unique: true, using: :btree

  end
end
