class CreateCountryZones < ActiveRecord::Migration[6.0]
  def change
    create_table :country_zones do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.boolean :enabled
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
