# PokemonGO Dump

This project aggregates data dumps from pokemon spawn databases.

### Data format

The entries are organized in a way to save space and permit quick merging here is the breakdown

```
./
./data/ (Contains dump data)
./data/lat[-90 to 90] (Latitude ceiling for the spawnpoint, -8.415 goes to lat-8)
./data/lat[-90 to 90]/long[-180 to 180]/ (Longitude ceiling for the spawnpoint)
./data/lat[-90 to 90]/long[-180 to 180]/[spawnpoint_id] (The JSON file contaning the spawnpoint data)
```

Inside spawnpoint file the dump follows the format

```
    {
        id: (spawnpoint_id),
        latitude: (obvious),
        longitude: (duh),
        spawn_time: (A integer representing the disappear time,
                    730 represents (730 / 60 =) 12 minutes and (730 % 60 =) 10 seconds every hour)
        pokemons: [
                    [encounter_id]: (the encounter id in base64 format) {
                                        id: (the pokemon_id),
                                        time: (the disappear timestamp in unix format)
                                    }
                 ]
    }
```
This saves space compared to .csv and .sql files, due to not repeating the same values over and over, and uses a universal and easily parsable format (json).

### How to restore data

To get in the data in .csv format just do:
```
ruby csv.rb
```

### How to send data

Upcoming...

### Upcoming Features

* Ability to get pogom.db dumps
* Parse Mysql PokemonGo-Map dumps
* Run tools in other languages (Python, NodeJS)
* Better CSV parameters
* Merging databases dumps
* Restore to SQL

### Developing...
