#!/bin/bash

# Figure out how to take input in case the user is ready to go.

echo "Good morning Ryan! Let me open some things up for you."
sleep 1

cd ~/Code/Github/development/nationwide_mobile_flutter
code -n .
sleep 1
open /Applications/iTerm.app

echo "Do you want me to run the app on a virtual device? (yes/no)"
read q1
if [[ q1 == "no" ]]; then
  exit 1
else
  # flutter emulators shows available emulators and we have grabbed the two emulator IDs and put them below
  echo "Would you like to use iOS(1) or android(2)? (1/2)"
  read sim
  if [[ sim == 1 ]]; then
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
fi
