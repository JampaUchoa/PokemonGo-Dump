# PokemonGO Dump

This project aggregates data dumps from pokemon spawn databases.

### Data format

The entries are organized in a way to save space and permit quick merging.

Files breakdown:

```
./
./data/ (Contains dump data)
./data/lat[-90 to 90] (Latitude ceiling for the spawnpoint, -8.415 goes to lat-8)
./data/lat[-90 to 90]/long[-180 to 180]/ (Longitude ceiling for the spawnpoint)
./data/lat[-90 to 90]/long[-180 to 180]/[spawnpoint_id] (The JSON file containing the spawnpoint data)
```

Inside the spawnpoint file the dump is structured like this:

```
{
  id: (spawnpoint_id),
  latitude: (obvious),
  longitude: (duh),
  spawn_time: (A integer representing the disappear time,
              730 represents (730 / 60 =) 12 minutes and (730 % 60 =) 10 seconds every hour),
  pokemons: [
              [encounter_id]: (the encounter id in base64 format) {
                id: (the pokemon_id),
                time: (the disappear timestamp in unix format)
              }
            ]
}
```
This saves space compared to .csv and .sql files, due to not repeating the same values over and over, and uses a universal and easily parseable format (.json).

### How to restore data

To get in the data in .csv format just do:
```
ruby csv.rb
```

### How to send data

If you have the data stored with Sqlite and PokemonGo-Map do the following:
  * Go to the PokemonGo-Map folder and find the ```pogom.db``` file
  * Copy the file to this project folder (PokemonGo-Dump)
  * Run ``` python sqlite.py  ```

### Upcoming Features

* Parse Mysql PokemonGo-Map dumps
* Run tools in other languages (Python, NodeJS)
* Better CSV parameters
* Merging databases dumps
* Restore to SQL
