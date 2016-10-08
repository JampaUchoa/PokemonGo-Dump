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
