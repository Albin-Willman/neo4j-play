require 'yaml'
namespace :dev_tools do


  desc "Create a bunch of cities and roads"
  task :import_data => :environment do
    cities_hash = {}
    CSV.foreach("#{Rails.root.to_s}/lib/data/cities.csv", :headers => true) do |csv_obj|
      city_name = csv_obj["Name"]
      cities_hash[city_name] = City.create({name: city_name})
      puts "City #{city_name} created"
    end

    CSV.foreach("#{Rails.root.to_s}/lib/data/roads.csv", :headers => true) do |csv_obj|
      from   = csv_obj["from"]
      to     = csv_obj["to"]
      length = csv_obj["length"]
      road1 = Road.new({length: length})
      road1.from_node = cities_hash[from]
      road1.to_node = cities_hash[to]
      road1.save!

      road2 = Road.new({length: length})
      road2.from_node = cities_hash[to]
      road2.to_node = cities_hash[from]
      road2.save!

      puts "Road from #{from} to #{to}"

    end
  end

end
