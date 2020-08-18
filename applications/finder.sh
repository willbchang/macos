echo "Application -> File Manager: Finder"
echo "  Finder -> General"
echo "    Hide icons for Hard disks on the desktop"
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

echo "    Show icons for External disks on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "    Hide icons for CDs, DVDs on the desktop"
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

echo "    Hide icons for Connected servers on the desktop"
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

echo "    New Finder windows show Home directory"
# User's Mac
#   NewWindowTarget: PfCm
# Macintosh HD - Data
#   NewWindowTarget: PfVo
#   NewWindowTargetPath: file:///
# Desktop:
#   NewWindowTarget: PfDe
#   NewWindowTargetPath: file:///Users/$(whoami)/Desktop/
# Documents:
#   NewWindowTarget: PfDo
#   NewWindowTargetPath: file:///Users/$(whoami)/Documents/
# iCloud Drive:
#   NewWindowTarget: PfID
#   NewWindowTargetPath: file:///Users/$(whoami)/Library/Mobile%20Documents/com~apple~CloudDocs/
# Recents:
#   NewWindowTarget: PfAF
#   NewWindowTargetPath: file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch
# For other paths, use "PfLo" and "file:///full/path/here/"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "    Open folders in tabs instead of new windows"
defaults write com.apple.finder FinderSpawnTab -bool true

echo "  Finder -> Sidebar"
echo "    Install tool to manage Finder sidebar: mysides"
brew cask install mysides

echo "    Remove Desktop from sidebar"
mysides remove Desktop

echo "    Remove Recents from sidebar"
mysides remove Recents

echo "    Add Home directory to sidebar"
mysides add $(whoami) file:///Users/$(whoami)

echo "    Remove Recent Tags from sidebar"
osascript finder-sidebar.scpt


echo "  Finder -> Advanced"
echo "    Show all file name extensions"
defaults write -g AppleShowAllExtensions -bool true

echo "    Disable warning before changing an extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "    Disable warning before removing from iCloud Drive" 
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

echo "    Disable warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "    Enable remove items from the Trash after 30 days"
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

echo "    Keep folders on top in windows when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "    Keep folders on top on Desktop when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

echo "    When performing a search, Search the Current Folder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"


