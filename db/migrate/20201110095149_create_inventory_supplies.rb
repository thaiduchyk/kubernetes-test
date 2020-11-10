class CreateInventorySupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_supplies do |t|
      t.integer :quantity, null: false
      t.float :value, null: false
      t.string :comment
      t.references :inventory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
