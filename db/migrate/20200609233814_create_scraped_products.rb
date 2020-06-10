class CreateScrapedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :scraped_products do |t|
      t.string :name
      t.float :price
      t.datetime :day_scraped
      t.string :manufacturer

      t.timestamps
    end
  end
end
