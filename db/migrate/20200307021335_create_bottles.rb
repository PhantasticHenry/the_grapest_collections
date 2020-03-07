class CreateBottles < ActiveRecord::Migration
  def change
    create_table :bottles do |t|
      t.string :wine_type
      t.integer :vintage
      t.float  :price
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
