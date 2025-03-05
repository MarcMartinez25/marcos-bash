#!/bin/bash

#source the config file
source ./config.env

#COLORS
GREEN='\e[32m';
CYAN='\e[36m';
RED='\e[31m';
YELLOW='\e[33m';
BLUE='\e[34m';
MAGENTA='\e[35m';
RESET='\e[0m';

# GREETING
echo ""
echo ""
echo -e "${RED}           ::::::::  :::::::::  :::::::::: :::::::::: ::::::::::: ::::::::::: ::::    :::  ::::::::   :::::::: ${RESET}"
echo -e "${YELLOW}          :+:    :+: :+:    :+: :+:        :+:            :+:         :+:     :+:+:   :+: :+:    :+: :+:    :+: ${RESET}"
echo -e "${GREEN}         +:+        +:+    +:+ +:+        +:+            +:+         +:+     :+:+:+  +:+ +:+        +:+         ${RESET}"
echo -e "${CYAN}        :#:        +#++:++#:  +#++:++#   +#++:++#       +#+         +#+     +#+ +:+ +#+ :#:        +#++:++#++   ${RESET}"
echo -e "${BLUE}       +#+   +#+# +#+    +#+ +#+        +#+            +#+         +#+     +#+  +#+#+# +#+   +#+#        +#+    ${RESET}"
echo -e "${BLUE}      #+#    #+# #+#    #+# #+#        #+#            #+#         #+#     #+#   #+#+# #+#    #+# #+#    #+#     ${RESET}"
echo -e "${MAGENTA}      ########  ###    ### ########## ##########     ###     ########### ###    ####  ########   ########       ${RESET}"
echo -e "${RESET}"
echo ""
echo -e "${MAGENTA} __________________________________________________________________________________________________________________ ${RESET}"
echo ""
echo -e "${MAGENTA} Hello $DEVELOPER. Today is" `date`
echo -e "${RESET}"

# FUNCTIONS
function get_weather {
  local url="https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$OPEN_WEATHER_API"

  response=$(curl -s "$url")

  if [[ -n "$response" ]]; then
    weather_overview=$(echo "$response" | jq -r '.weather[0].description')
    weather_overview=$(echo "$weather_overview" | sed -E 's/\..*//')
    temps=$(echo "$response" | jq -r '.main.temp')
    temp=$(echo "scale=2; ((($temps - 273.15) * 9) / 5) + 32" | bc)
    winds=$(echo "$response" | jq -r '.wind.speed')

    echo "Todays Weather: ${weather_overview} with temps around ${temp} and winds of ${winds}"
  else
    echo "Currently unable to get weather :("
  fi
}

# ALIAS
alias gw='get_weather'
alias gs='git status'
