use AppleScript version "2.5"
use scripting additions
use framework "Foundation"

on run argv
  set userName to quoted form of (item 1 of argv) as string
  set password to quoted form of (item 2 of argv) as string

  tell application "App Store"
    try
      log "Activating the app store..."
      activate
      delay 5
    end try
  end tell

  tell application "System Events"
    tell process "App Store"
      set frontmost to true
      delay 2
      try
        click button 2 of UI element 1 of sheet 1 of window 1
        delay 3
      end try
      click menu item 15 of menu "Store" of menu bar item "Store" of menu bar 1
      delay 2
      tell application "System Events" to keystroke userName
      delay 2
      tell application "System Events" to keystroke return
      delay 2
      tell application "System Events" to keystroke password
      delay 2
      tell application "System Events" to keystroke return
    end tell
  end tell

  tell application "App Store"
    try
      log "Quiting the app store..."
      delay 10
      quit
    end try
  end tell
end run
