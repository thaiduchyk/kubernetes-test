class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.float :amount, null: false
      t.string :payment_type, null: false
      t.string :transaction_id
      t.string :processor_response
      t.string :description
      t.references :order, null: false, foreign_key: true
      t.integer :legacy_id

      t.timestamps
    end
  end
end
