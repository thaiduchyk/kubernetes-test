class CreateInventoryTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_transitions do |t|
      t.integer :quantity, null: false
      t.string :comment
      t.references :from_inventory, null: false, foreign_key: { to_table: :inventories }
      t.references :to_inventory, null: false, foreign_key: { to_table: :inventories }

      t.timestamps
    end
  end
end
