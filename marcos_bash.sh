#!/bin/bash

#COLORS
GREEN='\e[32m';
CYAN='\e[36m';
RED='\e[31m'; # ERROR
YELLOW='\e[33m'; # WARNING
BLUE='\e[34m'; # INFO
MAGENTA='\e[35m'; # SUCCESS
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
    react)
      cd "$(cygpath -u "$REACT_DIR")" || return 1
      export PROMPT_COMMAND='echo -ne "\033]0;CIPS\007"'
      # echo -ne "\033]0;BASH\007"
      echo -e "${YELLOW}\n Switched to react repo ${RESET}"
      ;;
    ui)
      cd "$(cygpath -u "$UIKIT_DIR")" || return 1
      export PROMPT_COMMAND='echo -ne "\033]0;CIPS\007"'
      # echo -ne "\033]0;BASH\007"
      echo -e "${YELLOW}\n Switched to uikit repo ${RESET}"
      ;;
    *)
      echo -e "${BLUE} \n Usage: ct <dev | bash | react | ui> ${RESET}"
      echo -e "${BLUE} \n This will take you to the directory you set up in your config ${RESET}"
      return 1
      ;;
  esac
}

function clean_push() {
  case $1 in
    --help)
      echo -e "${BLUE} \n Usage: clean_push ${RESET}"
      echo -e "${BLUE} \n This will run the formatter and push changes ${RESET}"
      return 1
      ;;
    -h)
      echo -e "${BLUE} \n Usage: clean_push ${RESET}"
      echo -e "${BLUE} \n This will run the formatter and push changes ${RESET}"
      return 1
      ;;
    *)
      #dotnet 
      #git push

      echo -e "${MAGENTA}\n Files have been formatted and changes have been pushed ${RESET}"
      return 1
      ;;
  esac
}

function squash() {
  if [ -z "$1" ]; then
    echo -e "${BLUE} \n Usage: squash <number-of-commits> ${RESET}"
    return 1
  fi

  # run sed to modify pick/squash commands
  echo -e "${YELLOW}\n Starting interactive rebase for the last $1 commits... ${RESET}"
  GIT_SEQUENCE_EDITOR="sed -i '2,\$s/^pick/squash/'" git rebase -i HEAD~$1

  if [ $? -eq 0 ]; then

    # ask user if they want to see the git log
    echo -e "${MAGENTA}\n Rebase successful! Do you want to view the updated git log? (y/n):  ${RESET}"
    read -r log_choice
    if [[ "$log_choice" =~ ^[Yy]$ ]]; then
      git log --oneline --graph --decorate -n 10
    else
      echo -e "${MAGENTA}\n Done! ${RESET}"
    fi

    # ask user if they want to force push
    echo -e "${MAGENTA}\n Do you want to force push your changes? (y/n):  ${RESET}"
    read -r push_choice

    if [[ "$push_choice" =~ ^[Yy]$ ]]; then
      git push --force
    else
      echo -e "${MAGENTA}\n Force push skipped. ${RESET}"
    fi
  else
    echo -e "${RED}\n Rebase failed. Resolve conflicts and run 'git rebase --continue'. ${RESET}"
  fi
  
}

# ALIAS
alias gs='git status'
alias gcd="git checkout main"
alias gpod='git checkout origin main'
alias gb='git branch'
alias rg='npx gulp build'
# alias clean='dotnet '
