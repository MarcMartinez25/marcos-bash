# Marco's Bash Commands

this is still a work in progress and I will be adding new commands that will help me be more productive!

## Setup and Config

to use these commands you will need to add the `marcos_bash.sh` file to `.bashrc` like so:

```bash

source "{path-to-file}\marcos_bash.sh"

```

feel free to rename the file to whatever you want.

you will also need to create a `config.env` file to store your api keys and any other variable that will be created in the future. This file will be stored in the root directory of this project.

So far the variables you need to create are:
- OPEN_WEATHER_API
  - you will get this from openweathermap.org
  - ex: 'd52e7cced285fd3435634'
- LAT
  - latititude for api call
- LON
  - longitude for api call
- DEVELOPER
  - this will be your name!
  - ex: "Marco"

## Available Commands

``` bash
# runs 'git status'
gs

# gets weather based on location
gw

```
