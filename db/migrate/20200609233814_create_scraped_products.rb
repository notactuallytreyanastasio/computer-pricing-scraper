class CreateScrapedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :scraped_products do |t|
      t.string :name
      t.string :product_type
      t.float :price
      t.date :day_scraped

      t.timestamps
    end
  end
end
