#!/bin/bash

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
echo -e "${MAGENTA}     ########  ###    ### ########## ##########     ###     ########### ###    ####  ########   ########       ${RESET}"
echo -e "${RESET}"
echo ""
echo -e "${MAGENTA} __________________________________________________________________________________________________________________ ${RESET}"
echo ""
echo -e "${RED} Hello Marco. Today is" `date`
echo -e "${RESET}"


function get_weather {
  local api_key="enter-your-api-key-here"
  local lat="35.4757866"
  local lon="-97.5297775"
  local url="https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${api_key}"

  response=$(curl -s "$url")

  weather_overview=$(echo "$response" | jq -r '.weather[0].description')
  weather_overview=$(echo "$weather_overview" | sed -E 's/\..*//')

  temps=$(echo "$response" | jq -r '.main.temp')
  winds=$(echo "$response" | jq -r '.wind.speed')


  echo "Todays Weather: ${weather_overview} with temps around ${temp} and winds of ${winds}"
}

alias gw='get_weather'