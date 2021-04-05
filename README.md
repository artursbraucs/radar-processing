# Radar processing

ASCII radar data normalizer to find specific objects in it (called invaders).
All input data is stored in ./data directory.

## How to run

```
bin/exec
```

Will print out result with founded invaders with match score (only which is included by TOLLERANCE).
Also, it will print out clean, normalized radar with founded objects.

## Custom data

In lib/radar_processing.rb `RADAR_INPUT_LOCATION` and `INVADERS_INPUT_LOCATION` can
be changed to different locations. `TOLLERANCE` should be adjusted as well for new data (most likely it would be between 0.1 for good signal data and 0.3 for very bad signal data). With bigger tollerance value it is more likely to get false positives.

## Approch

Very naive approch reasonable space complexity and brute force matching.

## Run tests

```
bundle install
bundle exec rspec
```
