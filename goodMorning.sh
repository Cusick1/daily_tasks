#!/bin/bash

# Figure out how to take input in case the user is ready to go.

function get_repo() {

  mobileFlutter="nationwide_mobile_flutter"
  flutterUI="nationwide_flutter_ui"
  icons="nationwide_flutter_icons"
  claimAPI="eim-claim-api"
  mx="mobilex"
  model="nw-model"

  echo "So which is it today, front end, or back end? (F/B)"
  read fb_end
    if [[ $fb_end != "f" && $fb_end != "F" && $fb_end != "b" &&  $fb_end != "B" ]]; then
    until [ $fb_end == "f" ] || [ $fb_end == "F" ] || [ $fb_end == "b" ] || [ $fb_end == "B" ]
    do
    echo "What was that? Let's try again."
    echo "So which is it today, front end, or back end? (F/B)"
    read fb_end
    done
  fi

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

    cd ~/Code/Github/development/$repo_name
    code -n .
    sleep 1
    open /Applications/iTerm.app

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

    cd ~/Code/Github/backend/$repo_name
    idea .
    sleep 1
    open /Applications/iTerm.app

  fi
}

function virtual_device() {
  echo "Do you want me to run the app on a virtual device? (yes/no)"
  read q1
  if [[ $q1 == "yes" ]]; then
    # flutter emulators shows available emulators and we have grabbed the two emulator IDs and put them below
    echo "Would you like to use iOS(1) or android(2)? (1/2)"
    read sim
    if [[ $sim == 1 ]]; then
      flutter emulators --launch apple_ios_simulator
    else
      ps aux | grep -i emulator | grep -i Pixel_4a | wc -l | read test | if [ "$test" != "0" ]; then
      echo "emulator is alread running" 
      else 
        flutter emulators --launch Pixel_4a
      fi
    fi

    open /Applications/iTerm.app

    echo "Would you like to run the app via the command line? (yes/no)"
    read cmdLine
    if [[ $cmdLine == "no" ]]; then
    open /Applications/Visual\ Studio\ Code.app
    # Run Application through VSCode using AppleScript to bring VSCode to an active position if not open and press F5.
      osascript -e 'tell application "Visual Studio Code"
        activate
      end tell
      tell application "System Events"
        delay 3
        key code 96
      end tell'  
    else
      # Run Application through command line
      echo "Are you ready to run the app? (yes/no)"
      read answer
      if [[ $answer != "yes" ]]; then 
        until [ $answer == "yes" ]
        do
        echo "Are you ready yet? (yes/no)"
        read answer
        done
      fi
      echo "Alright go grab yourself some coffee while I get this up and running!"
      sleep 2
      if [[ sim == "1" ]]; then
        open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/
      else
        osascript -e 'tell application "System Events"
          tell UI element "qemu-system-x86_64" of list 1 of application process "Dock"
            perform action "AXPress"
          end tell
        end tell'

        # source ~/Learning/Bash/showEmulator.sh
      fi
      open /Applications/Visual\ Studio\ Code.app
      #() allows it to run in subshell
      (flutter run)
      echo "You disconected from the Simulator!"
    fi
  else
     echo "Sounds good"
     sleep 1
  fi
}

function main() {

  echo "Good morning Ryan! Let me open some things up for you."
  sleep 1

  get_repo

  virtual_device

}

main




