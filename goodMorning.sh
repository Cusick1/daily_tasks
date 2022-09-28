#!/bin/bash

# Figure out how to take input in case the user is ready to go.
function virtual_device() {
  read -r -p "Do you want me to run the app on a virtual device? (yes/no): " q1
  if [[ $q1 == "yes" ]]; then
    read -r -p "Would you like to use iOS(1) or android(2)? (1/2): " sim
    while [ "$sim" != "1" ] && [ "$sim" != "2" ]; do
      read -r -p "Would you like to use iOS(1) or android(2)? (1/2): " sim
    done
    if [[ $sim == 1 ]]; then
      # flutter emulators shows available emulators and we have grabbed the emulator names and put them after launch
      flutter emulators --launch apple_ios_simulator
    elif [[ $sim == 2 ]]; then
      response=$(ps aux | grep -i emulator | grep -i -c Pixel_4a)
      if [ "$response" != "0" ]; then
        echo "Your Android emulator is already running"
      else
        echo "I'll open up your Pixel 4a"
        flutter emulators --launch Pixel_4a
      fi
    fi

    open /Applications/iTerm.app
    read -r -p "Would you like to run the app via the command line? (yes/no): " cmdLine
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
      read -r -p "Are you ready to run the app? (yes/no): " answer
      if [[ $answer != "yes" ]]; then
        until [ "$answer" == "yes" ]; do
          read -r -p "Are you ready yet? (yes/no): " answer
        done
      fi
      echo "Alright go grab yourself some coffee while I get this up and running!"
      sleep 2
      if [[ $sim == "1" ]]; then
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
    echo "Sounds good, everything should be up an running then!"
    sleep 1
  fi
}

function get_repo() {
  mobileFlutter="nationwide_mobile_flutter"
  flutterUI="nationwide_flutter_ui"
  icons="nationwide_flutter_icons"
  claimAPI="eim-claim-api"
  mx="mobilex"
  model="nw-model"

  read -r -p "So which is it today, front end, or back end? (F/B): " fb_end
  if [[ $fb_end != "f" && $fb_end != "F" && $fb_end != "b" && $fb_end != "B" ]]; then
    until [ "$fb_end" == "f" ] || [ "$fb_end" == "F" ] || [ "$fb_end" == "b" ] || [ "$fb_end" == "B" ]; do
      echo "What was that? Let's try again."
      read -r -p "So which is it today, front end, or back end? (F/B): " fb_end
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
    read -r repo

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

    virtual_device

  elif [[ $fb_end == "B" || $fb_end == "b" ]]; then
    echo "Backend... Nice."
    sleep 1
    echo "I'm sure this will be fun."
    sleep 1
    echo "Uughhh.........."
    echo "Which repo we thinking?
1: $mx
2: $claimAPI
3: $model
    "
    read -r repo
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

function welcome_failed() {
  echo "
             ____________________________________________________
            /                                                    \\
           |    _____________________________________________     |
           |   |                                             |    |           
           |   |             ___          ___                |    |
           |   |            /   \\        /   \\               |    |
           |   |           |     |      |     |              |    |
           |   |           | [ ] |      | [ ] |              |    |
           |   |           \\_____/      \\_____/              |    |
           |   |                                             |    |
           |   |                ____________                 |    |
           |   |               /            \\                |    |
           |   |               \\____________/                |    |
           |   |                                             |    |
           |   |---------------------------------------------|    |
           |   |  That wasn't quite the enter key.           |    |
           |   |  Are you ready to get started?              |    |
           |   |  If so, press the enter key.                |    |           
           |   |_____________________________________________|    |
           |                                                      |
            \_____________________________________________________/
                   \_______________________________________/
                _______________________________________________
             _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- \`-_
          _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.\`-_
       _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-\`__\`. .-.-.-.\`-_
    _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.\`-_
 _-'.-.-.-.-.-. .---.-. .-----------------------------. .-.---. .---.-.-.-.\`-_
:-----------------------------------------------------------------------------:
\`---._.-----------------------------------------------------------------._.---'
"

  read -n 1 -s -r get_started
  if [[ $get_started == '' ]]; then
    return
  else
    welcome_failed
  fi
}

function welcome() {
  echo "
             ____________________________________________________
            /                                                    \\
           |    _____________________________________________     |
           |   |                                             |    |           
           |   |             ___          ___                |    |
           |   |            /   \\        /   \\               |    |
           |   |           |     |      |     |              |    |
           |   |           | [ ] |      | [ ] |              |    |
           |   |           \\_____/      \\_____/              |    |
           |   |                                             |    |
           |   |                ____________                 |    |
           |   |               /            \\                |    |
           |   |               \\____________/                |    |
           |   |                                             |    |
           |   |---------------------------------------------|    |
           |   |  Welcome Ryan. Good morning!                |    |
           |   |  Let me open some things up for you.        |    |
           |   |  Press enter to get started.                |    |           
           |   |_____________________________________________|    |
           |                                                      |
            \_____________________________________________________/
                   \_______________________________________/
                _______________________________________________
             _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- \`-_
          _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.\`-_
       _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-\`__\`. .-.-.-.\`-_
    _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.\`-_
 _-'.-.-.-.-.-. .---.-. .-----------------------------. .-.---. .---.-.-.-.\`-_
:-----------------------------------------------------------------------------:
\`---._.-----------------------------------------------------------------._.---'
"
  read -n 1 -s -r get_started
  if [[ $get_started == '' ]]; then
    return
  else
    clear_screen
    welcome_failed
  fi
}

function clear_screen() {
  printf "\033c"
}

function main() {
  clear_screen
  welcome
  sleep 1
  clear_screen
  get_repo
}

main
