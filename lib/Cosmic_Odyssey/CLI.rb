class CosmicOdyssey::CLI 
  
  def call 
    
    #get_planet_info
    puts <<~DOC
      ____________________________ 
     |                            |
     |****************************|
     | Welcome to COSMIC ODYSSEY! |
     |****************************|
     |____________________________|
    
    
    
     --------START  EXIT----------
    
      DOC
      start_or_exit
    end
    
    def start_or_exit
      user_input = gets.strip
      
      case user_input
        when "start"
          start_app
        when "exit"
          goodbye
        else
          start_or_exit
      end
    end
    
    def start_app
    @input = ""
    until @input == "exit"
      get_system_bodies
      get_planets
      get_user_planets
      seen_enough
    end
  end
  
  def get_system_bodies
    #will be scraped
    
    @planets = CosmicOdyssey::Planet.all 
    # binding.pry 
  end
  
  def get_planets
    #list planets
    puts "\nChoose a Planet to start our journey!!\n\n\n"
    @planets.each.with_index(1) { |planet, index, name| 
      puts "#{index}. #{planet.name}"
    }
  end
  
  def get_user_planets
    chosen_planet = gets.strip.to_i
    show_planet(chosen_planet) if valid_input(chosen_planet.to_i, @planets)
  end
  
  def valid_input(input, data)
    input.to_i <= data.length && input.to_i > 0
  end
  
  def show_planet(chosen_planet)
    planet = @planets[chosen_planet-1]
    puts "\n\n\nWelcome to #{planet.name}!\n\n\n"
    CosmicOdyssey::Scraper.update_planet(planet)
    puts <<~DOC
     #{planet.description}
     #{}
     #{planet.brief_history_0}
     #{}
     #{planet.brief_history_2}
     #{}
     #{planet.brief_history_3}
     #{}
     #{planet.brief_history_4}
     #{}
     #{planet.fun_fact}
     
     DOC
  end
  
  def seen_enough
    puts "--Seen enough? Type 'exit' to return home--\n", "\n--To see another celestial body hit any key.--"
    @input = gets.strip
  end 
  
  def goodbye
    puts "See you next time on...COSMIC ODYSSEY!!"
  end 

  
  
  
end
