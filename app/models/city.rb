class City
  include Neo4j::ActiveNode

  has_many :out, :cities, rel_class: Road
  property :name, type: String


  def distance_to(target_city)
    map_out_graph[target_city.id]
  end


  def map_out_graph possible_roads = {}, traveled_length = 0
    cities.each_with_rel do |city, road|
      possible_length = traveled_length + road.length
      if possible_roads[city.id].nil? ||
        (possible_roads[city.id] > possible_length)
        possible_roads[city.id] = possible_length
        possible_roads = city.map_out_graph(possible_roads, possible_length)
      end
    end
    possible_roads
  end

  def find_all_connected_cities visited_cities = [self.id]
    cities.each do |city|
      unless visited_cities.include?(city.id)
        visited_cities << city.id
        visited_cities = city.find_all_connected_cities(visited_cities)
      end
    end
    visited_cities
  end

  def traveling_sales_route
    complete_set = City.find_all_connected_cities
    routes = {}
    shortest = nil
    complete_set.each do |set|
      last = nil
      length = 0
      early_break = false
      set.each do |city_id|
        next_city = City.find(city_id)
        if last

          length += last.distance_to next_city

        end
        last = next_city

      end
      shortest = {route: set, length: length} if length < shortest[:length]
    end

  end



  def self.get_permutations array
    return [array] if array.length == 1

    ret = []
    array.each do |element|
      City.get_permutations(array-[element]).each do |permutation|
        ret << (permutation << element)
      end
    end
    ret
  end

end
