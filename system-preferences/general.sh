echo "Setup System Preferences -> General"

echo "  Set appearance to auto"
# https://apple.stackexchange.com/a/391814/306411
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

echo "  Set accent color to Pink"
# Accent Color
# Red           : 0
# Orange        : 1
# Yellow        : 2
# Green         : 3
# Blue          : 4
# Purple        : 5
# Pink          : 6
# Logan         : 7
# Paris Daisy   : 8
# Coral         : 9
# Silver        : 10
defaults write -g AppleAccentColor -int 6

echo "  Set highlight color to Pink"
# Highlight color
# Red      : "1.000000 0.733333 0.721569"
# Orange   : "1.000000 0.874510 0.701961"
# Yellow   : "1.000000 0.937255 0.690196"
# Green    : "0.752941 0.964706 0.678431"
# Blue     : "0.847059 0.847059 0.862745" (default)
# Purple   : "0.968627 0.831373 1.000000"
# Pink     : "1.000000 0.749020 0.823529
# Brown    : "0.929412 0.870588 0.792157"
# Graphite : "0.847059 0.847059 0.862745"
# Silver   : "0.776500 0.776500 0.776500" (custom)
# Above data is from :https://github.com/buo/dotfiles/blob/master/osx/_01general.sh
# Calculate on your own: https://apple.stackexchange.com/a/164905/306411
defaults write -g AppleHighlightColor -string "1.000000 0.749020 0.823529 Pink"

echo "  Set sidebar icon size to medium"
# Small  : 1
# Medium : 2 (default)
# Large  : 3
defaults write -g NSTableViewDefaultSizeMode -int 2

echo "  Hide the menu bar Automatically"
defaults write -g _HIHideMenuBar -bool true

echo "  Show scroll bars automatically"
# Automatically based on mouse or trackpad : "Automatic"
# When scrolling                           : "WhenScrolling"
# Always                                   : "Always"
defaults write -g AppleShowScrollBars -string "Automatic"

# Jump to the spot that's clicked : true
# Jump to the next page           : false
echo "  Click in the scroll bar to jump to the sport that's clicked"
defaults write -g AppleScrollerPagingBehavior -bool true

echo "  Set default browser to Chrome"
# You can set default app for different filetypes
# Check ./default_apps.rb
html='
<dict>
    <key>LSHandlerContentType</key>
    <string>public.html</string>
    <key>LSHandlerPreferredVersions</key>
    <dict>
        <key>LSHandlerRoleAll</key>
        <string>-</string>
    </dict>
    <key>LSHandlerRoleAll</key>
    <string>com.google.chrome</string>
</dict>
'

xhtml='
<dict>
    <key>LSHandlerContentType</key>
    <string>public.xhtml</string>
    <key>LSHandlerPreferredVersions</key>
    <dict>
        <key>LSHandlerRoleAll</key>
        <string>-</string>
        <key>LSHandlerRoleViewer</key>
        <string>-</string>
    </dict>
    <key>LSHandlerRoleAll</key>
    <string>com.google.chrome</string>
</dict>
'

http='
<dict>
    <key>LSHandlerPreferredVersions</key>
    <dict>
        <key>LSHandlerRoleAll</key>
        <string>-</string>
    </dict>
    <key>LSHandlerRoleAll</key>
    <string>com.google.chrome</string>
    <key>LSHandlerURLScheme</key>
    <string>http</string>
</dict>
'

https='
<dict>
    <key>LSHandlerPreferredVersions</key>
    <dict>
        <key>LSHandlerRoleAll</key>
        <string>-</string>
    </dict>
    <key>LSHandlerRoleAll</key>
    <string>com.google.chrome</string>
    <key>LSHandlerURLScheme</key>
    <string>https</string>
</dict>
'

defaults write ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist LSHandlers -array-add "$html" "$xhtml" "$http" "$https"

echo "  Disable ask to keep changes when closing documents"
defaults write -g NSCloseAlwaysConfirmsChanges -bool false

echo "  Close windows when quitting an app"
# When it's true, open documents and windows will not be restored when you re-open an app.
defaults write -g NSQuitAlwaysKeepsWindows -bool true

echo "  Set recent items to 0"
# The relative file is in ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.RecentDocuments.sfl2
# sfltool nolonger work for sfl2 after 10.13, but you may change the .sfl2 to .plist and manipulate with `defaults write` then change the extension back. It may work but I never try it because there is a simpler way to use apple script.
# https://github.com/buo/dotfiles/blob/d2145bb247700a0cf1018cf351c32a796151befa/osx/_01general.sh#L48-L50
for category in 'applications' 'documents' 'servers'; do
  /usr/bin/osascript -e "tell application \"System Events\" to tell appearance preferences to set recent $category limit to 0"
done

echo "  Set Allow Handoff between this Mac and your iCloud devices"
# Inspired by https://www.jamf.com/jamf-nation/discussions/12545/a-script-to-disable-handoff
defaults -currentHost write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool yes
defaults -currentHost write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool yes

# Use font smoonthing when available
# defaults -currentHost delete -g AppleFontSmoothing
