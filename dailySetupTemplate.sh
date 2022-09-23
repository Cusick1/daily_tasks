#!/bin/bash

echo "Good morning NAME! Let me open some things up for you."
sleep 1

cd ~/PATH/TO/REPO/nationwide_mobile_flutter
code -n .
sleep 1
open /Applications/iTerm.app #or your terminal of choice

# type the command flutter emululators in your terminal to see a list of available emulators
# update the names below withe the first name in each line following the command
echo "Would you like to use iOS or android? (1/2)"
read sim
if [[ sim == 1 ]]; then
  flutter emulators --launch IOS_SIMULATOR_NAME
else
  ps aux | grep -i emulator | grep -i ANDROID_EMULATOR_NAME | wc -l | read test | if [ "$test" != "0" ]; then
   echo "emulator is alread running" 
  else 
    flutter emulators --launch ANDROID_EMULATOR_NAME
  fi
fi

open /Applications/iTerm.app #or your terminal of choice (if you use default terminal the path will be different)

echo "Would you like to run the app via the command line? (y/n)"
read cmdLine
if [[ $cmdLine == "n" ]]; then
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
  echo "Are you ready to run the app? (y/n)"
  read answer
  if [[ $answer != "y" ]]; then 
    until [ $answer == "y" ]
    do
    echo "Are you ready yet? (y/n)"
    read answer
    done
  fi
  echo "Alright go grab yourself some coffee while I get this up and running!"
  sleep 2
  if [[ sim == "1" ]]; then
    open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/
  else
  # REPLACE qemu-system-x86_64 WITH THE STRING THAT SHOWS UP FOR YOUR EMULATOR ICON IN THE DOCK
    osascript -e 'tell application "System Events"
      tell UI element "qemu-system-x86_64" of list 1 of application process "Dock"
        perform action "AXPress"
      end tell
    end tell'
  fi
  open /Applications/Visual\ Studio\ Code.app
  #() allows it to run in subshell
  (flutter run)
  echo "You disconected from the Simulator!"
fi

