class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :match_id
      t.integer :match_seq_num
      t.datetime :start_time
      t.string :lobby_type

      t.timestamps
    end
  end
end
