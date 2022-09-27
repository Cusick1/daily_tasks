#!/bin/bash


function get_repo() {

  mobileFlutter="nationwide_mobile_flutter"
  flutterUI="nationwide_flutter_ui"
  icons="nationwide_flutter_icons"
  claimAPI="eim-claim-api"
  mx="mobilex"
  model="nw-model"

  echo "So which is it today, front end, or back end? (F/B)"
  read fb_end
  # if [[ $fb_end != "f" || $fb_end != "F" || $fb_end != "b" ||  $fb_end != "B" ]]; then
  #   until [ $fb_end == "f" || $fb_end == "F" || $fb_end == "b" ||  $fb_end == "B" ]
  #   do
  #   echo "What was that? Let's try again."
  #   echo "So which is it today, front end, or back end? (F/B)"
  #   read fb_end
  #   done
  # fi

  if [[ $fb_end == "F" || $fb_end == "f" ]]; then
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
  elif [[ $fb_end == "B" || $fb_end == "b" ]]; then
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
  # instead of setting value we could return the variable we have depending on what we wnat to do
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
}

get_repo 
echo $repo_name
