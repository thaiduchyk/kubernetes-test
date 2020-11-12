class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku, null: false
      t.string :name, null: false
      t.string :description
      t.float :price, null: false
      t.float :shipping_price, null: false
      t.string :buy_link
      t.string :image_path
      t.string :image_name
      t.boolean :enabled
      t.boolean :include_in_feed
      t.boolean :page_canoe
      t.boolean :page_kayak
      t.boolean :page_inflatable
      t.boolean :page_boats
      t.boolean :page_parts
      t.boolean :page_plans

      t.timestamps
    end
  end
end
