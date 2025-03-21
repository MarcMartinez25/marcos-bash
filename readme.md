# Marco's Bash Commands

this is still a work in progress and I will be adding new commands that will help me be more productive!

## Setup and Config

- to use these commands you will need to add the `marcos_bash.sh` file to `.bashrc`
   - (feel free to rename the file to whatever you want)
 - you will also need to create a `config.env` file to store your api keys and any other variable that will be created in the future. This file will be stored in the root directory of this project but you will need to also add it to the `.bashrc` file as well.

 here is an example of what your `.bashrc` file should look like:

 ```bash

source "{path-to-file}\marcos_bash.sh"
source "{path-to-config}\config.env"

 ```

### Config Variables


```bash
OPEN_WEATHER_API="{YOU-API-KEY}" # you will get this from openweathermap.org
ZIP="90210" # Zipcode is used for getting the weather based on your desired location
DEVELOPER="Ricky Bobby" # whatever name you want to commands to call you

DEV_DIR="path-to-development-dir" # this can be whatever path you want.
DEV_DIR_NAME="development" # this is what you want to name your dev_dir
BASH_DIR="path-to-this-repo" # this is the path to this repo.
```

### Available Commands

``` bash

# Usage: gets weather based on location
weather

# Usage: brancy <branch-name>
# Creates a new branch and sets up the upstream
branchy

# Usage: del_branch <branch-name> <local|remote|both>
# Deletes the branch user inputted either locally, remotely, or both
del_branch

# Usage: ct <dev | bash>
# This will take you to the directory you set up in your config and rename the title of the tab
ct

# Usage: squash <number-of-commits>
# This will allow you to squash the last n commits, view the git log and force push your changes.
squash

# runs 'git status'
gs

# runs 'git checkout main'
gcd

#runs 'git pull origin main'
gpod

# runs 'git branch
gb
```
