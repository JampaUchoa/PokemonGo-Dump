import sqlite3
import os
import errno
import math
import json
from datetime import datetime

def create_dir(path): #create dir if it doesnt exist
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise

db = sqlite3.connect('pogom.db', detect_types=sqlite3.PARSE_DECLTYPES|sqlite3.PARSE_COLNAMES)

with db:

    cur = db.cursor()
    cur.execute("SELECT *, disappear_time as '[timestamp]' FROM pokemon ORDER BY spawnpoint_id ASC")

    while True:

        row = cur.fetchone()

        if row == None:
            break

        #Define variables

        encounter_id = row[0]
        spawnpoint_id = row[1]
        pokemon_id = row[2]
        latitude = row[3]
        longitude = row[4]
        disappear_time = row[-1].strftime("%s")

        create_dir("data")

        lat = "data/lat%d" % math.ceil(latitude)
        lon = "%s/lon%d" % (lat, math.ceil(longitude))

        create_dir(lat)
        create_dir(lon)

        json_file = "%s/%s" % (lon, spawnpoint_id)

        if os.path.isfile(json_file):
            with open(json_file) as data_file:
                spawn = json.load(data_file)

            exist = False
            for sp in spawn["pokemons"]:
                if sp.has_key(encounter_id):
                    exist = True
                    break
            if exist:
                print "Spawn exists... Skipping it"
            else:
                spawn["pokemons"].append({encounter_id: {"id": pokemon_id, "time": disappear_time}})
            with open(json_file, 'w') as data_file:
                data_file.write(json.dumps(spawn, sort_keys = True, separators=(',', ':')))

        else:
            spawn = {}
            spawn["id"] = spawnpoint_id
            spawn["latitude"] = latitude
            spawn["longitude"] = longitude
            spawn["pokemons"] = []
            spawn["pokemons"].append({encounter_id: {"id": pokemon_id, "time": disappear_time}})

            with open(json_file, 'w') as data_file:
                data_file.write(json.dumps(spawn, sort_keys = True, separators=(',', ':')))
