#!/bin/bash

#test

mobileFlutter="nationwide_mobile_flutter"
flutterUI="nationwide_flutter_ui"
icons="nationwide_flutter_icons"
claimAPI="eim-claim-api"
mx="mobilex"
model="nw-model"

echo "So which is it today, front end, or back end? (F/B)"
read fbEnd
if [[ $fbEnd == "F" ]]; then
  echo "Awesome, front end it is!"
  sleep 1
  echo "Which repo are we working in?
  1: $mobileFlutter
  2: $flutterUI
  3: $icons
  "
  read repo
  
  case $repo in
  1)
    repo_name=$mobileFlutter
    ;;
  2)
    repo_name=$flutterUI
    ;;
  3)
    repo_name=$icons
    ;;
  esac
else
  echo "Backend... Nice."
  sleep 1
  echo "I'm sure this will be fun."
  sleep 1
  echo "Uughh. Which repo we thinking?
  1: $mx
  2: $claimAPI
  3: $model
  "
 
   read repo

  case $repo in
  1)
    repo_name=$mx
    ;;
  2)
    repo_name=$claimAPI
    ;;
  3)
    repo_name=$model
    ;;
  esac
fi

print($repo_name)
