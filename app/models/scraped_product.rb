require 'net/http'

class ScrapedProduct < ApplicationRecord
  POWER_SUPPLIES_URL = URI("https://www.evga.com/products/productlist.aspx?type=10")

  def self.scrape_psus
    page = Nokogiri::HTML(Net::HTTP.get_response(POWER_SUPPLIES_URL).body)
    all_links = page.css('a').to_a
    product_links = all_links.select { |link| link.attributes["class"]&.value == "pl-list-pname" }
    product_names = product_links.map { |link| link.children.first.text }
    prices = page.css('.pl-list-pricing').to_a.map { |p| p.text }.map { |p| p.squish }

    sanitized_prices = prices.map do |p|
      price_start_index = p.index("$")
      price = p[price_start_index..(price_start_index + 7)].squish
      price.gsub(" Li", "").gsub(" L", "").gsub(" Q", "").gsub("$", "").gsub(" C", "").gsub("T", "")
    end.map(&:to_f)

    Hash[product_names.zip(sanitized_prices)]
  end
end
