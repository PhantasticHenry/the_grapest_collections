class CreateBottles < ActiveRecord::Migration
  def change
    create_table :bottles do |t|

      t.timestamps null: false
    end
  end
end
