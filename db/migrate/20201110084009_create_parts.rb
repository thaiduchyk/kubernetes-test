class CreateParts < ActiveRecord::Migration[6.0]
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.boolean :direct_shipment, null: false
      t.boolean :placeholder, null: false

      t.timestamps
      t.index :name, unique: true
    end
  end
end
