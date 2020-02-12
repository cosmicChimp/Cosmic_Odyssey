class CosmicOdyssey::Scraper
  BASE_URL = "https://nineplanets.org/"
  def self.scrape_planets
    site = "#{BASE_URL}kids/"

    page = Nokogiri::HTML(open(site))
    # puts page
    planets = page.css("ul.planets-thumbnail-list li")
    
    planets.each do |p|
      name = p.css('span').text
      planet = CosmicOdyssey::Planet.new(name)
      planet.url = BASE_URL + p.css('a').attr('href').value
    end
  end
  
  def self.update_planet(planet)
    site = planet.url
    page = Nokogiri::HTML(open(site))
    
    planet.description = page.css('div.hero h2').text
  
    if page.css("tr.ninja_table_row_4 td")[0].text == "Orbit Distance:"
      planet.dfs = page.css("tr.ninja_table_row_4 td")[1].text
    end
  end
  
end