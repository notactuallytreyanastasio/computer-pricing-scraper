class AddLinkToScrapedProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :scraped_products, :link, :string
  end
end
