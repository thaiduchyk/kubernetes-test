class CreateOrderNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :order_notes do |t|
      t.string :text, null: false
      t.references :order, null: false, foreign_key: true
      t.integer :legacy_id

      t.timestamps
    end
  end
end
