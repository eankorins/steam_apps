class AddDetailsToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :kills, :integer
    add_column :participants, :deaths, :integer
    add_column :participants, :assists, :integer
    add_column :participants, :kda, :string
    add_column :participants, :leaver_status, :string
    add_column :participants, :gold, :integer
    add_column :participants, :last_hits, :integer
    add_column :participants, :denies, :integer
    add_column :participants, :gold_spent, :integer
    add_column :participants, :hero_damage, :integer
    add_column :participants, :tower_damage, :integer
    add_column :participants, :hero_healing, :integer
    add_column :participants, :level, :integer
    add_column :participants, :xpm, :integer
    add_column :participants, :gpm, :integer
    add_column :participants, :items, :string
    add_column :participants, :additional_unit_items, :string
    add_column :participants, :additional_unit_names, :string
    add_column :participants, :upgrades, :string
  end
end
