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
echo -e "${MAGENTA}      ########  ###    ### ########## ##########     ###     ########### ###    ####  ########   ########       ${RESET}"
echo -e "${RESET}"
echo ""
echo -e "${MAGENTA} __________________________________________________________________________________________________________________ ${RESET}"
echo ""
echo -e "${MAGENTA} Hello $DEVELOPER. Today is" `date`
echo -e "${RESET}"

# FUNCTIONS
function weather {
  local url="https://api.openweathermap.org/data/2.5/weather?zip=$ZIPCODE,us&appid=$OPEN_WEATHER_API"

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

function branchy() {

  if [ -z "$1" ]; then
    echo -e "${BLUE} \n Usage: brancy <branch-name>${RESET}"
    return 1
  fi

  git checkout -b "$1"
  git push --set-upstream origin "$1"

  echo -e "${MAGENTA}\n Switched to new branch: $1 and set upstream to origin/$1 ${RESET}"
}

function del_branch() {
  if [ -z "$1" ]; then
    echo -e "${BLUE} \n Usage: del_branch <branch-name> <local | remote | both> ${RESET}"
    return 1
  fi

  branch_name="$1"
  delete_option="$2" 

  case "$delete_option" in
    local)
      git branch -d "$branch_name"
      echo -e "${YELLOW} \n Deleted local branch: $branch_name ${RESET}"
      ;;
    remote)
      git push origin --delete "$branch_name"
      echo -e "${YELLOW} \n Deleted remote brach: origin/$branch_name ${RESET}"
      ;;
    both)
      git branch -d "$branch_name"
      git push origin --delete "$branch_name"
      echo -e "${YELLOW} \n Deleted branch $branch_name on both local and remote ${RESET}"
      ;;
    *)
      echo -e "${RED}"
      echo "Invalid option: $delete_option. You must input local, remote, or both"
      echo "Usage: del_branch <branch-name> <local|remote|both>"
      echo -e ${RESET}
      return 1
      ;;
  esac

}

function ct() {
 
  case "$1" in
    dev)
      cd "$(cygpath -u "$DEV_DIR")" || return 1
      export PROMPT_COMMAND='echo -ne "\033]0;CIPS\007"'
      # echo -ne "\033]0;CIPS\007"
      echo -e "${YELLOW}\n Switched to $DEV_DIR_NAME repo ${RESET}"
      ;;
    bash)
      cd "$(cygpath -u "$BASH_DIR")" || return 1
      export PROMPT_COMMAND='echo -ne "\033]0;CIPS\007"'
      # echo -ne "\033]0;BASH\007"
      echo -e "${YELLOW}\n Switched to bash repo ${RESET}"
      ;;
    *)
      echo -e "${BLUE} \n Usage: ct <dev | bash> ${RESET}"
      echo -e "${BLUE} \n This will take you to the directory you set up in your config ${RESET}"
      return 1
      ;;
  esac


}

# ALIAS
alias gs='git status'
alias gcd="git checkout main"
alias gpod='git checkout origin main'
alias gb='git branch'
