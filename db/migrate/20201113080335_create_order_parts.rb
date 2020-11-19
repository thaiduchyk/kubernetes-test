class CreateOrderParts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_parts do |t|
      t.integer :quantity, null: false
      t.references :order, null: false, foreign_key: true
      t.references :part, null: false, foreign_key: true

      t.timestamps
    end
  end
end
