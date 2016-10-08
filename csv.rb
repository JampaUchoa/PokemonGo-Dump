require "json"

#p "Warning not specifying parameters will result in a BIG FILE."
file = "./output.csv"

File.open(file, 'w') do |file|

  file.write("spawnpoint_id,latitude,longitude,pokemon_id,encounter_id,disappear_time\n")

  spawns = []
  Dir.glob("./data/*").each do |lat|
    Dir.glob("#{lat}/*").each do |lng|
      spawns << Dir.glob("#{lng}/*")
    end
  end
  spawns.flatten!

  spawns.each do |sp|
    spawn_data = JSON.parse(File.read(sp))
    commons = "#{spawn_data["id"]},#{spawn_data["latitude"]},#{spawn_data["longitude"]}"
    spawn_data["pokemons"].each do |enc|
      file.write(commons + ",#{enc.values.first["id"]},#{enc.keys.first},#{enc.values.first["time"]}\n")
    end
  end

end

=begin
 spawnpoints = Pokemon.pluck(:spawnpoint_id).uniq #where(city: "recife")
 remain = spawnpoints.count

 p "Parsing #{remain}"

 spawns_result = []


 spawnpoints.each do |sp|

   this_spawn = {}
   this_spawn["id"] = sp
   this_spawn["latitude"] = Pokemon.where(spawnpoint_id: sp).first.latitude
   this_spawn["longitude"] = Pokemon.where(spawnpoint_id: sp).first.longitude

   make_dir("export_data/lat#{this_spawn["latitude"].ceil}")
   make_dir("export_data/lat#{this_spawn["latitude"].ceil}/lon#{this_spawn["longitude"].ceil}")

   file = "export_data/lat#{this_spawn["latitude"].ceil}/lon#{this_spawn["longitude"].ceil}/#{this_spawn["id"]}"

#   currentfile = JSON.parse(File.read(file)) if File.exists?(file)

   time_sum = 0
   spawns = Pokemon.where(spawnpoint_id: sp)
   dtimes = spawns.pluck(:disappear_time)

   dtimes.each do |time|
     time_sum += (time.strftime('%M').to_i * 60) + time.strftime('%S').to_i
   end

   avg_time = (time_sum / dtimes.count)

   this_spawn["spawn_time"] = avg_time
   this_spawn["pokemons"] = []

   spawns.each do |sp|
     this_spawn["pokemons"] << {"#{sp.encounter_id}": {id: sp.pokemon_id, time: sp.disappear_time.to_i}}
   end

   File.open(file, 'w') { |file| file.write(this_spawn.to_json) }

   remain -= 1
   p "Parsing #{remain}"

 end

end
=end
