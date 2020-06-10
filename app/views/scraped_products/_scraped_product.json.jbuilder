json.extract! scraped_product, :id, :name, :price, :day_scraped, :manufacturer, :created_at, :updated_at
json.url scraped_product_url(scraped_product, format: :json)
