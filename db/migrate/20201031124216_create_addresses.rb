class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :company
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :line_1, null: false
      t.string :line_2
      t.string :postal_code
      t.string :city, null: false
      t.string :country, null: false
      t.string :country_zone

      # we need to decide if we want to store and validate country and zone
      # there are UI tools which can validate address on their side
      # t.references :country, foreign_key: true
      # t.references :country_zone, foreign_key: true

      t.timestamps
    end
  end
end
