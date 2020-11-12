class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :fullname, null: false
      t.string :email, null: false
      t.string :password
      t.boolean :active
      t.references :shipping_address, null: false, foreign_key: { to_table: :addresses }
      t.references :billing_address, null: false, foreign_key: { to_table: :addresses }

      t.timestamps
    end
  end
end
