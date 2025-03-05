# Marco's Bash Commands

this is still a work in progress and I will be adding new commands that will help me be more productive!

## Setup and Config

- to use these commands you will need to add the `marcos_bash.sh` file to `.bashrc` like so:

```bash

source "{path-to-file}\marcos_bash.sh"

```
(feel free to rename the file to whatever you want)

 - you will also need to create a `config.env` file to store your api keys and any other variable that will be created in the future. This file will be stored in the root directory of this project.

### Config Variables

```bash
OPEN_WEATHER_API="{YOU-API-KEY}" # you will get this from openweathermap.org
ZIP="90210" # Zipcode is used for getting the weather based on your desired location
DEVELOPER="Ricky Bobby" # whatever name you want to commands to call you
```

### Available Commands

``` bash
# runs 'git status'
gs

# gets weather based on location
gw

```
