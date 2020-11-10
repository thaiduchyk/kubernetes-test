class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.integer :quantity, null: false
      t.string :location, null: false
      t.references :part, null: false, foreign_key: true

      t.timestamps
      t.index [:part_id, :location], unique: true
    end
  end
end
