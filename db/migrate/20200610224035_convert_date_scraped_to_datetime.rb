class ConvertDateScrapedToDatetime < ActiveRecord::Migration[6.0]
  def change
    change_column :scraped_products, :day_scraped, :datetime
  end
end
