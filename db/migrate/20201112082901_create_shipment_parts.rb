class CreateShipmentParts < ActiveRecord::Migration[6.0]
  def change
    create_table :shipment_parts do |t|
      t.integer :quantity, null: false
      t.references :shipment, null: false, foreign_key: true
      t.references :part, null: false, foreign_key: true
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
