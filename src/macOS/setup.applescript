use AppleScript
use scripting additions
use framework "Foundation"
use application "Finder"

property CURRENT_USER       : missing value as string
property SCRIPT_PATH        : missing value as string
property INSTALL_PERMITTED  : boolean
property HOMEBREW_INSTALLED : boolean

on ensureHomebrewIsInstalled()
  set installed to false as boolean
  try
    set brew to (POSIX file "/usr/local/bin/brew") as alias
    tell application "Finder" to set installed to exists brew
  on error
    set installed to false
  end try
end ensureHomebrewIsInstalled

on requestPermissionsToInstall()
  set permissionGranted to display dialog ¬¨
    "Install Homebrew?" buttons { "No", "Yes" }
  if permissionGranted's button returned is equal to "No" then return false
  if permissionGranted's button returned is equal to "Yes" then return true
end requestPermissionsToInstall


on run
  set HOMEBREW_INSTALLED to ensureHomebrewIsInstalled() as boolean
  if HOMEBREW_INSTALLED is equal to true then return
  tell application "Finder" to set SCRIPT_PATH to get the (POSIX path of (container of (path to me) as alias)) & "scripts/deps.sh" as string
  set CURRENT_USER to (system attribute "USER") as string
  set INSTALL_PERMITTED to requestPermissionsToInstall() as boolean
  if CURRENT_USER is equal to "root" then
    error "Setup should be done as a regular user"
  end if
  if INSTALL_PERMITTED is equal to true then
    do shell script "sh " & SCRIPT_PATH
  else
    set alert to display alert ¬¨
      "Please install Homebrew manually" buttons {"Cancel", "Ok, take me there"} as warning ¬¨
      default button "Cancel" cancel button "Cancel" giving up after 3
    if alert's button returned is equal to "Ok, take me there" then
      open location "https://brew.sh"
    end if
  end if
end run
