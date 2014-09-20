class CreateHeroes < ActiveRecord::Migration
  def change
    create_table :heroes, :id => false, :force => true do |t|
      t.integer :id, :options => 'PRIMARY KEY'
      t.string :name

      t.timestamps
    end
  end
end
