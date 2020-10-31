class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :iso_code_2, null: false
      t.string :iso_code_3, null: false
      t.string :address_format
      t.boolean :postcode_required
      t.boolean :enabled

      t.timestamps
      t.index :name, unique: true
    end
  end
end
