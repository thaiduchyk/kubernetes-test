class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.float :product_cost, null: false
      t.float :shipping_cost, null: false
      t.float :product_total, null: false
      t.references :order, null: false, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :legacy_id

      t.timestamps
    end
  end
end
