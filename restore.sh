#!/bin/bash

# Ensure the script is not run as root
if [ "$(id -u)" -eq 0 ]; then
    echo "Do not run this script as root. Exiting..."
    exit 1
fi

# Cache password for script execution
cache_password() {
    echo "Caching your password for script execution..."
    read -sp "Enter your password: " PASSWORD
    echo
    export SUDO_ASKPASS=$(mktemp)
    echo "#!/bin/bash" > "$SUDO_ASKPASS"
    echo "echo \"$PASSWORD\"" >> "$SUDO_ASKPASS"
    chmod +x "$SUDO_ASKPASS"
    echo "Password cached successfully!"
}

# Cleanup cached password
cleanup_password_cache() {
    rm -f "$SUDO_ASKPASS"
    unset PASSWORD
    unset SUDO_ASKPASS
    echo "Password cache cleaned up."
}

# Test SUDO_ASKPASS functionality
test_sudo_askpass() {
    echo "Testing sudo with cached password..."
    sudo -A echo "Sudo is working with cached password!"
    if [ $? -ne 0 ]; then
        echo "Error: Sudo with cached password failed!"
        exit 1
    fi
}

# Initialize DEPNotify
initialize_depnotify() {
    DEP_NOTIFY_LOG="/var/tmp/depnotify.log"
    sudo -A touch "$DEP_NOTIFY_LOG"
    sudo -A chown "$USER" "$DEP_NOTIFY_LOG"
    chmod u+w "$DEP_NOTIFY_LOG"
    
    open -a "/Applications/Utilities/DEPNotify.app"
    echo "Command: MainTitle: macOS Restoration in Progress" >> "$DEP_NOTIFY_LOG"
    echo "Command: MainText: Please wait while your Mac is being configured." >> "$DEP_NOTIFY_LOG"
}

# Update DEPNotify Status
update_depnotify_status() {
    local message="$1"
    echo "Status: $message" >> /var/tmp/depnotify.log
}

# Quit DEPNotify
quit_depnotify() {
    echo "Command: Quit" >> /var/tmp/depnotify.log
    rm -f /var/tmp/depnotify.log
}

# Function to install DEPNotify
install_depnotify() {
    echo "Installing DEPNotify..."
    DEP_NOTIFY_URL="https://files.nomad.menu/DEPNotify.pkg"
    TEMP_DIR=$(mktemp -d)
    DEP_NOTIFY_PKG="$TEMP_DIR/DEPNotify.pkg"
    
    echo "Downloading DEPNotify from $DEP_NOTIFY_URL..."
    update_depnotify_status "Downloading DEPNotify..."
    curl -L --insecure "$DEP_NOTIFY_URL" -o "$DEP_NOTIFY_PKG"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download DEPNotify."
        exit 1
    fi
    
    echo "Installing DEPNotify..."
    update_depnotify_status "Installing DEPNotify..."
    sudo -A installer -pkg "$DEP_NOTIFY_PKG" -target /
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install DEPNotify."
        exit 1
    fi
    
    echo "Cleaning up..."
    rm -rf "$TEMP_DIR"
    update_depnotify_status "DEPNotify installed successfully!"
}

# Install Dockutil
install_dockutil() {
    echo "Installing Dockutil..."
    DOCKUTIL_URL="https://github.com/kcrawford/dockutil/releases/download/3.1.3/dockutil-3.1.3.pkg"
    TEMP_DIR=$(mktemp -d)
    DOCKUTIL_PKG="$TEMP_DIR/dockutil.pkg"
    
    echo "Downloading Dockutil from $DOCKUTIL_URL..."
    update_depnotify_status "Downloading Dockutil..."
    curl -L --insecure "$DOCKUTIL_URL" -o "$DOCKUTIL_PKG"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download Dockutil."
        exit 1
    fi
    
    echo "Installing Dockutil..."
    update_depnotify_status "Installing Dockutil..."
    sudo -A installer -pkg "$DOCKUTIL_PKG" -target /
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Dockutil."
        exit 1
    fi
    
    echo "Cleaning up..."
    rm -rf "$TEMP_DIR"
    update_depnotify_status "Dockutil installed successfully!"
}

#!/bin/bash

# Ensure the script is not run as root
if [ "$(id -u)" -eq 0 ]; then
    echo "Do not run this script as root. Exiting..."
    exit 1
fi

# Cache password for script execution
cache_password() {
    echo "Caching your password for script execution..."
    read -sp "Enter your password: " PASSWORD
    echo
    export SUDO_ASKPASS=$(mktemp)
    echo "#!/bin/bash" > "$SUDO_ASKPASS"
    echo "echo \"$PASSWORD\"" >> "$SUDO_ASKPASS"
    chmod +x "$SUDO_ASKPASS"
    echo "Password cached successfully!"
}

# Cleanup cached password
cleanup_password_cache() {
    rm -f "$SUDO_ASKPASS"
    unset PASSWORD
    unset SUDO_ASKPASS
    echo "Password cache cleaned up."
}

# Test SUDO_ASKPASS functionality
test_sudo_askpass() {
    echo "Testing sudo with cached password..."
    sudo -A echo "Sudo is working with cached password!"
    if [ $? -ne 0 ]; then
        echo "Error: Sudo with cached password failed!"
        exit 1
    fi
}

# Initialize DEPNotify
initialize_depnotify() {
    DEP_NOTIFY_LOG="/var/tmp/depnotify.log"
    sudo -A touch "$DEP_NOTIFY_LOG"
    sudo -A chown "$USER" "$DEP_NOTIFY_LOG"
    chmod u+w "$DEP_NOTIFY_LOG"
    
    open -a "/Applications/Utilities/DEPNotify.app"
    echo "Command: MainTitle: macOS Restoration in Progress" >> "$DEP_NOTIFY_LOG"
    echo "Command: MainText: Please wait while your Mac is being configured." >> "$DEP_NOTIFY_LOG"
}

# Update DEPNotify Status
update_depnotify_status() {
    local message="$1"
    echo "Status: $message" >> /var/tmp/depnotify.log
}

# Quit DEPNotify
quit_depnotify() {
    echo "Command: Quit" >> /var/tmp/depnotify.log
    rm -f /var/tmp/depnotify.log
}

# Function to install DEPNotify
install_depnotify() {
    echo "Installing DEPNotify..."
    DEP_NOTIFY_URL="https://files.nomad.menu/DEPNotify.pkg"
    TEMP_DIR=$(mktemp -d)
    DEP_NOTIFY_PKG="$TEMP_DIR/DEPNotify.pkg"
    
    echo "Downloading DEPNotify from $DEP_NOTIFY_URL..."
    update_depnotify_status "Downloading DEPNotify..."
    curl -L --insecure "$DEP_NOTIFY_URL" -o "$DEP_NOTIFY_PKG"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download DEPNotify."
        exit 1
    fi
    
    echo "Installing DEPNotify..."
    update_depnotify_status "Installing DEPNotify..."
    sudo -A installer -pkg "$DEP_NOTIFY_PKG" -target /
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install DEPNotify."
        exit 1
    fi
    
    echo "Cleaning up..."
    rm -rf "$TEMP_DIR"
    update_depnotify_status "DEPNotify installed successfully!"
}

# Install Dockutil
install_dockutil() {
    echo "Installing Dockutil..."
    DOCKUTIL_URL="https://github.com/kcrawford/dockutil/releases/download/3.1.3/dockutil-3.1.3.pkg"
    TEMP_DIR=$(mktemp -d)
    DOCKUTIL_PKG="$TEMP_DIR/dockutil.pkg"
    
    echo "Downloading Dockutil from $DOCKUTIL_URL..."
    update_depnotify_status "Downloading Dockutil..."
    curl -L --insecure "$DOCKUTIL_URL" -o "$DOCKUTIL_PKG"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download Dockutil."
        exit 1
    fi
    
    echo "Installing Dockutil..."
    update_depnotify_status "Installing Dockutil..."
    sudo -A installer -pkg "$DOCKUTIL_PKG" -target /
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Dockutil."
        exit 1
    fi
    
    echo "Cleaning up..."
    rm -rf "$TEMP_DIR"
    update_depnotify_status "Dockutil installed successfully!"
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        update_depnotify_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" <<< ""
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install Homebrew."
            exit 1
        fi
        
        # Add Homebrew to the shell environment for the current user
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    # Add Homebrew to the current PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
    update_depnotify_status "Updating Homebrew..."
    brew update
    update_depnotify_status "Homebrew installed and updated successfully!"
}
# Install Homebrew apps
install_homebrew_apps() {
    APPS=(
        google-chrome
        visual-studio-code
        spotify
        slack
        iterm2
        firefox
        fsmonitor
        1password
        parallels
        coderunner
        imazing-profile-editor
        chatgpt
        notion
        discord
        pppc-utility
        windows-app
    )
    
    update_depnotify_status "Installing applications with Homebrew..."
    for app in "${APPS[@]}"; do
        update_depnotify_status "Installing $app..."
        if ! brew install --cask "$app"; then
            echo "Error: Failed to install $app. Skipping..."
            update_depnotify_status "Failed to install $app. Skipping..."
            continue
        fi
        update_depnotify_status "$app installed successfully!"
    done
    update_depnotify_status "Applications installed successfully!"
}

# Install GitHub apps
install_github_apps() {
    GITHUB_APPS=(
        "https://github.com/txhaflaire/JamfCheck/releases/download/2.2.0/JamfCheck-2.2.0.pkg"
        "https://github.com/jamf/Jamf-Environment-Test/releases/download/1.6.1/Jamf.Environment.Test.app.zip"
        "https://github.com/Jamf-Concepts/jamf-compliance-editor/releases/download/v1.4/JamfComplianceEditor-1.4.0.pkg"
        "https://github.com/jamf/mut/releases/download/v6.2.1/MUT.app.zip"
    )
    
    TEMP_DIR=$(mktemp -d)
    update_depnotify_status "Installing GitHub applications..."
    for app_url in "${GITHUB_APPS[@]}"; do
        file_name=$(basename "$app_url")
        app_path="$TEMP_DIR/$file_name"
        
        update_depnotify_status "Downloading $(basename "$app_url")..."
        curl -L --insecure "$app_url" -o "$app_path"
        if [[ "$file_name" == *.pkg ]]; then
            update_depnotify_status "Installing $file_name..."
            sudo -A installer -pkg "$app_path" -target /
        elif [[ "$file_name" == *.zip ]]; then
            update_depnotify_status "Unzipping $file_name..."
            unzip -q "$app_path" -d "/Applications"
        fi
        if [ $? -ne 0 ]; then
            echo "Error: Failed to process $file_name."
            update_depnotify_status "Failed to process $file_name. Skipping..."
            continue
        fi
    done
    update_depnotify_status "GitHub applications installed successfully!"
    rm -rf "$TEMP_DIR"
}

# Install Mac Evaluation Utility
install_mac_evaluation_tool() {
    MAC_EVALUATION_URL="https://beta.apple.com/download/1019260"
    
    update_depnotify_status "Opening Mac Evaluation Utility download page..."
    osascript <<EOF
    display dialog "To complete installation, click 'Sign In' below to open Appleseed for IT and download the Mac Evaluation Tool." buttons {"Cancel", "Sign In"} default button "Sign In" with title "Mac Evaluation Tool Installation Required" with icon note
    if button returned of result is "Sign In" then
        do shell script "open '$MAC_EVALUATION_URL'"
    end if
EOF
    
    update_depnotify_status "Waiting for user to complete the download..."
    
    # Poll for the presence of the downloaded file
    while [ ! -f ~/Downloads/Mac_Evaluation_Utility_4.6.5.dmg ]; do
        sleep 5
    done
    
    update_depnotify_status "Installing Mac Evaluation Utility..."
    
    TEMP_DIR=$(mktemp -d)
    hdiutil attach ~/Downloads/Mac_Evaluation_Utility_4.6.5.dmg -mountpoint "$TEMP_DIR" -nobrowse
    MAC_EVALUATION_PKG=$(find "$TEMP_DIR" -name "*.pkg" | head -n 1)
    
    if [ -z "$MAC_EVALUATION_PKG" ]; then
        echo "Error: No .pkg found in the mounted .dmg."
        update_depnotify_status "Failed to find installer in the disk image."
        hdiutil detach "$TEMP_DIR"
        rm -rf "$TEMP_DIR"
        return 1
    fi
    
    sudo -A installer -pkg "$MAC_EVALUATION_PKG" -target /
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Mac Evaluation Utility."
        update_depnotify_status "Failed to install Mac Evaluation Utility."
        hdiutil detach "$TEMP_DIR"
        rm -rf "$TEMP_DIR"
        return 1
    fi
    
    update_depnotify_status "Mac Evaluation Utility installed successfully!"
    hdiutil detach "$TEMP_DIR"
    rm -rf "$TEMP_DIR"
}


# Install Python packages in a virtual environment
install_python_packages() {
    PYTHON_ENV=~/python-env
    update_depnotify_status "Setting up Python environment..."
    if [ ! -d "$PYTHON_ENV" ]; then
        python3 -m venv "$PYTHON_ENV"
    fi
    source "$PYTHON_ENV/bin/activate"
    update_depnotify_status "Installing Python packages (numpy, pandas, matplotlib)..."
    pip install --upgrade pip
    pip install numpy pandas matplotlib
    deactivate
    update_depnotify_status "Python environment and packages set up successfully!"
}

# Restore macOS Settings
restore_macos_settings() {
    update_depnotify_status "Restoring macOS settings..."
    
    mkdir -p ~/Documents/Screenshots
    defaults write com.apple.screencapture location ~/Documents/Screenshots
    update_depnotify_status "Set screenshot location."
    
    defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
    update_depnotify_status "Enabled Dark mode."
    
    defaults write com.apple.dock show-recents -bool false
    defaults write com.apple.dock mru-spaces -bool false
    update_depnotify_status "Updated Dock preferences."
    
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
    update_depnotify_status "Restored Trackpad preferences."
    
    update_depnotify_status "MacOS Settings reset completed."
}

# Restore Dock Layout
restore_dock_layout() {
    update_depnotify_status "Restoring Dock layout..."
    
    # Path to Dockutil
    DOCKUTIL="/usr/local/bin/dockutil"
    
    # Get the currently logged-in user
    loggedInUser=$(stat -f%Su /dev/console)
    
    # Validate Dockutil installation
    if [ ! -x "$DOCKUTIL" ]; then
        echo "Dockutil is not installed. Please install it first."
        exit 1
    fi
    
    # Get the user's home directory
    userHome=$(dscl . -read /Users/"$loggedInUser" NFSHomeDirectory | awk '{print $2}')
    
    if [ ! -d "$userHome" ]; then
        echo "Could not find the home directory for $loggedInUser."
        exit 1
    fi
    
    # Remove existing Dock items
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --remove all --no-restart --homeloc "$userHome"
    update_depnotify_status "Cleared existing Dock items."
    
    
    # Add items to the Dock
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Slack.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Safari.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Google Chrome.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Firefox.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Messages.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Spotify.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/ChatGPT.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Calendar.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/CodeRunner.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/iMazing Profile Editor.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Jamf Compliance Editor.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Mac Evaluation Utility.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/FSMonitor.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/1Password.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Windows App.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/Applications/Parallels Desktop.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/System/Applications/Utilities/Terminal.app" --no-restart --homeloc "$userHome"
    sudo -u "$loggedInUser" -H "$DOCKUTIL" --add "/System/Applications/System Settings.app" --homeloc "$userHome"
    
    # Restart the Dock
    sudo -u "$loggedInUser" -H killall Dock
    update_depnotify_status "Restored Dock Layout."
}


# Main Script Execution
main() {
    cache_password
    test_sudo_askpass

    echo "Starting macOS restore process..."

    install_depnotify
    initialize_depnotify

    update_depnotify_status "Installing Homebrew..."
    install_homebrew
    
    update_depnotify_status "Installing Homebrew Apps..."
    install_homebrew_apps
    
    update_depnotify_status "Installing Github Apps..."
    install_github_apps
    
    update_depnotify_status "Installing MacOS Evaluation Tool..."
    install_mac_evaluation_tool 
    
    update_depnotify_status "Installing Dockutil..."
    install_dockutil

    update_depnotify_status "Installing Python packages..."
    install_python_packages

    update_depnotify_status "Restoring macOS settings..."
    restore_macos_settings

    update_depnotify_status "Restoring Dock layout..."
    restore_dock_layout
    sleep 2

    update_depnotify_status "Cleanup in progress..."
    quit_depnotify
    cleanup_password_cache

    echo "macOS restoration complete!"
    sleep 2
}

main
