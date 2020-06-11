require 'scraper'



namespace :scrapers do
  task :scrape_components, :environment do
    ["motherboard", "gpu", "power_supply"].each do |component|
      require 'scraper'
      EVGA::Scraper.new(component).scrape
    end
  end
end
