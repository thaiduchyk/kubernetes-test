class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :number, null: false
      t.string :status, null: false
      t.float :total, null: false
      t.float :shipping_cost
      t.float :tax
      t.string :sale_channel, null: false
      t.references :customer, null: false, foreign_key: true
      t.references :shipping_address, null: false, foreign_key: { to_table: :addresses }
      t.references :billing_address, null: false, foreign_key: { to_table: :addresses }

      t.timestamps
    end
  end
end
