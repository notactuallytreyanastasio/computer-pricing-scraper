require 'net/http'

module EVGA
  class Scraper
    POWER_SUPPLIES_URI = URI("https://www.evga.com/products/productlist.aspx?type=10")
    GPUS_URI = URI("https://www.evga.com/products/ProductList.aspx?type=0")
    MOTHERBOARDS_URI = URI("https://www.evga.com/products/ProductList.aspx?type=1")

    SCRAPABLE = ["motherboard", "gpu", "power_supply"]
    def initialize(scrape_type)
      @scrape_type = scrape_type
      case @scrape_type
      when "motherboard"
        @page = Nokogiri::HTML(Net::HTTP.get_response(MOTHERBOARDS_URI).body)
        @offset = 8 when "gpu"
        @page = Nokogiri::HTML(Net::HTTP.get_response(GPUS_URI).body)
        @offset = 8
      when "power_supply"
        @page = Nokogiri::HTML(Net::HTTP.get_response(POWER_SUPPLIES_URI).body)
        @offset = 7
      else
        raise "Invalid entry given to scrape. Valid entries are #{SCRAPABLE.join(", ")}"
      end
    end

    def scrape
      all_links      = @page.css('a').to_a
      product_links  = all_links.select { |link| link.attributes["class"]&.value == "pl-list-pname" }
      @purchase_links = product_links.map { |p| p.attributes.fetch("href").value }
      product_names  = product_links.map { |link| link.children.first.text }
      prices         = @page.css('.pl-list-pricing').to_a.map { |p| p.text }.map { |p| p.squish }
      clean_prices   = prices.map { |price| sanitize_price(price) }
      prices_hash    = Hash[product_names.zip(clean_prices)]

      @i = 0
      prices_hash.map do |product_name, price|
        link = @purchase_links[@i]
        @i = @i + 1
        product = ScrapedProduct.new(
          name: product_name,
          price: price,
          product_type: @scrape_type,
          day_scraped: Time.now,
          link: link,
        )
        product.save
        product
      end
    end

    def sanitize_price(bad_price)
      price_start_index = bad_price.index("$")
      price = bad_price[price_start_index..(price_start_index + @offset)].squish
      price.
        gsub(" Li", "").
        gsub(" L", "").
        gsub(" Q", "").
        gsub("$", "").
        gsub(" C", "").
        gsub("T", "").
        gsub("In", "")
    end
  end
end
