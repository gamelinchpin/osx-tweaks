#!/usr/bin/env ruby

def setting(text, settings = {})
  printf text
  setting = gets.chomp.downcase
  if setting == 'y' || settings == 'yes'
    system settings[:yes]
  elsif setting == 'n' || setting == 'no'
    system settings[:no]
  else
    puts "No change made."
  end
end

puts "**********************************************************************"
puts "This script doesn't make any change without your confirmation."
puts "You'll be prompted before make any change."
puts "Choices are: y (Yes), n (No), enter (Skip)"
puts "**********************************************************************"
printf "Do you want to start running the script (y/n)? "

return if gets.chomp.downcase != 'y'

system 'sudo -v'
system 'while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &'

setting "Save to disk, rather than iCloud, by default? ",
  yes:  "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud FALSE",
  no:   "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud TRUE"

setting "Check for software updates daily, not just once per week? ",
  yes:  "defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1",
  no:   "defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7"

setting "Disable auto-correct? ",
  yes:  "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled FALSE",
  no:   "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled TRUE"

setting "Require password immediately after sleep or screen saver begins? ",
  yes:  "defaults write com.apple.screensaver askForPassword TRUE",
  no:   "defaults write com.apple.screensaver askForPasswordDelay FALSE"

setting "Enable subpixel font rendering on non-Apple LCDs? ",
  yes:  "defaults write NSGlobalDomain AppleFontSmoothing -int 2",
  no:   "defaults delete NSGlobalDomain AppleFontSmoothing"

setting "Increase the window resize speed for Cocoa applications? ",
  yes:  "defaults write NSGlobalDomain NSWindowResizeTime -float 0.1",
  no:   "defaults delete NSGlobalDomain NSWindowResizeTime"

setting "Enable tap to click (Trackpad)? ",
  yes:  "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking TRUE",
  no:   "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking FALSE"

### Menu Bar ###
setting "Menu bar: Disable Spotlight? ",
  yes:  "sudo chmod 700 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search",
  no:   "sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search"

setting "Menu bar: Disable transparency? ",
  yes:  "defaults write NSGlobalDomain AppleEnableMenuBarTransparency FALSE",
  no:   "defaults write NSGlobalDomain AppleEnableMenuBarTransparency TRUE"

### Time Machine ###
setting "Time Machine: Disable local snapshots ",
  yes:  "sudo tmutil disablelocal",
  no:   "sudo tmutil enablelocal"

### Finder ###
setting "Finder: Show the ~/Library folder ",
  yes:  "chflags nohidden ~/Library",
  no:   "chflags hidden ~/Library"

setting "Finder: Show icons for hard drives, servers, and removable media on the desktop? ",
  yes:  "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop TRUE",
  no:   "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop TRUE"

setting "Finder: Show hidden files by default? ",
  yes:  "defaults write com.apple.Finder AppleShowAllFiles TRUE",
  no:   "defaults write com.apple.Finder AppleShowAllFiles FALSE"

setting "Finder: Show all filename extensions by default? ",
  yes:  "defaults write NSGlobalDomain AppleShowAllExtensions TRUE",
  no:   "defaults write NSGlobalDomain AppleShowAllExtensions FALSE"

setting "Finder: Show status bar by default? ",
  yes:  "defaults write com.apple.finder ShowStatusBar TRUE",
  no:   "defaults write com.apple.finder ShowStatusBar FALSE"

setting "Finder: Display full POSIX path as window title? ",
  yes:  "defaults write com.apple.finder _FXShowPosixPathInTitle TRUE",
  no:   "defaults write com.apple.finder _FXShowPosixPathInTitle FALSE"

setting "Finder: Disable the warning when changing a file extension? ",
  yes:  "defaults write com.apple.finder FXEnableExtensionChangeWarning FALSE",
  no:   "defaults write com.apple.finder FXEnableExtensionChangeWarning TRUE"

setting "Finder: Use column view in all windows by default? ",
  yes:  "defaults write com.apple.finder FXPreferredViewStyle Clmv",
  no:   "defaults write com.apple.finder FXPreferredViewStyle icnv"

setting "Finder: Avoid creation of .DS_Store files on network volumes? ",
  yes:  "defaults write com.apple.desktopservices DSDontWriteNetworkStores TRUE",
  no:   "defaults write com.apple.desktopservices DSDontWriteNetworkStores FALSE"

### Mision Control ###
setting "Mission Control: Speed up animations? ",
  yes:  "defaults write com.apple.dock expose-animation-duration -float 0.1",
  no:   "defaults delete com.apple.dock expose-animation-duration"

setting "Mission Control: Group windows by application? ",
  yes:  "defaults write com.apple.dock \"expose-group-by-app\" -bool true",
  no:   "defaults write com.apple.dock \"expose-group-by-app\""

### Dock ###
setting "Dock: Enable auto-hide? ",
  yes:  "defaults write com.apple.dock autohide TRUE",
  no:   "defaults write com.apple.dock autohide FALSE"

setting "Dock: Remove the auto-hiding delay? ",
  yes:  "defaults write com.apple.dock autohide-delay -float 0 &&
        defaults write com.apple.dock autohide-time-modifier -float 0",
  no:   "defaults delete com.apple.dock autohide-delay &&
        defaults delete com.apple.dock autohide-time-modifier"

### Safari ###
setting "Safari: Search default to Contains instead of Starts With? ",
  yes:  "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly FALSE",
  no:   "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly TRUE"

setting "Safari: Allow hitting the Backspace key to go to the previous page in history? ",
  yes:  "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled TRUE",
  no:   "defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled"

setting "Safari: Show full website address? ",
  yes:  "defaults write com.apple.Safari ShowFullURLInSmartSearchField TRUE",
  no:   "defaults write com.apple.Safari ShowFullURLInSmartSearchField FALSE"

### Mail.app ###
setting "Mail.app: Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'? ",
  yes:  "defaults write com.apple.mail AddressesIncludeNameOnPasteboard FALSE",
  no:   "defaults write com.apple.mail AddressesIncludeNameOnPasteboard TRUE"

### House Cleaning ###
setting "Clear Out Font Caches? ",
  yes:  "sudo atsutil databases -remove"

puts "**********************************************************************"
puts "We're done!!!"
puts "Note that some of these changes require a logout/restart to take effect."
