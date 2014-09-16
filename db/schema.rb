# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140916195135) do

  create_table "achievements", force: true do |t|
    t.string   "name"
    t.integer  "game_id"
    t.integer  "defaultvalue"
    t.string   "displayname"
    t.integer  "hidden"
    t.string   "description"
    t.string   "icon"
    t.string   "icongray"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["name"], name: "index_achievements_on_name", unique: true

  create_table "completed_achievements", force: true do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "player_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "appid"
    t.string   "cost"
    t.string   "played"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "achievements_count", default: 0
    t.integer  "stats_count",        default: 0
    t.integer  "playedgames_count",  default: 0
  end

  add_index "games", ["appid"], name: "index_games_on_appid", unique: true

  create_table "matches", force: true do |t|
    t.integer  "match_id"
    t.integer  "match_seq_num"
    t.datetime "start_time"
    t.string   "lobby_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "winner"
    t.integer  "first_blood"
    t.integer  "season"
    t.integer  "duration"
    t.integer  "human_players"
    t.integer  "positive_votes"
    t.integer  "negative_votes"
    t.integer  "cluster"
    t.string   "mode"
    t.integer  "league_id"
    t.integer  "radiant_tower_status"
    t.integer  "dire_tower_status"
    t.integer  "radiant_barracks_status"
    t.integer  "dire_barracks_status"
  end

  add_index "matches", ["match_id"], name: "index_matches_on_match_id"

  create_table "participants", force: true do |t|
    t.string   "player_id"
    t.integer  "player_slot"
    t.integer  "hero_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.string   "kda"
    t.string   "leaver_status"
    t.integer  "gold"
    t.integer  "last_hits"
    t.integer  "denies"
    t.integer  "gold_spent"
    t.integer  "hero_damage"
    t.integer  "tower_damage"
    t.integer  "hero_healing"
    t.integer  "level"
    t.integer  "xpm"
    t.integer  "gpm"
    t.string   "items"
    t.string   "additional_unit_items"
    t.string   "additional_unit_names"
    t.text     "upgrades"
  end

  add_index "participants", ["player_id"], name: "index_participants_on_player_id"

  create_table "playedgames", force: true do |t|
    t.integer  "player_id"
    t.integer  "game_id"
    t.float    "playedtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playedgames", ["player_id"], name: "index_playedgames_on_player_id"

  create_table "players", id: false, force: true do |t|
    t.string   "account_id",                         null: false
    t.string   "name"
    t.string   "real_name"
    t.string   "clan_id"
    t.string   "country_code"
    t.string   "state_code"
    t.datetime "profile_created_at"
    t.string   "access_state"
    t.boolean  "configured"
    t.string   "status"
    t.datetime "last_login"
    t.string   "profile_url"
    t.string   "small_avatar"
    t.string   "medium_avatar"
    t.string   "large_avatar"
    t.boolean  "commentable"
    t.integer  "current_game_id"
    t.string   "current_game_title"
    t.string   "current_game_server_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playedgames_count",      default: 0
    t.integer  "total_time",             default: 0
  end

  add_index "players", ["account_id"], name: "index_players_on_account_id", unique: true

  create_table "stats", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.integer  "value"
    t.string   "displayname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["name"], name: "index_stats_on_name", unique: true

end
