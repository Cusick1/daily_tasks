#!/usr/bin/osascript

tell application "System Events"
  tell UI element "qemu-system-x86_64" of list 1 of application process "Dock"
    perform action "AXPress"
  end tell
end tell
