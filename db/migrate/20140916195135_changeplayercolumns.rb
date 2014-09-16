class Changeplayercolumns < ActiveRecord::Migration
  def change
  	change_column :participants, :upgrades, :text, :limit => nil
  end
end
