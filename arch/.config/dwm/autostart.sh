#!/bin/bash

# Log file location
LOGFILE="$HOME/.autostart.log"

# Function to log messages with a timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

# Log start of the script
log "Starting autostart.sh script."

# Example: Logging when the autostart script is reached
log "autostart.sh reached."

# Touchpad Tapping
log "Configuring touchpad tapping."
xinput set-prop CUST0001:00\ 06CB:7E7E\ Touchpad "libinput Tapping Enabled" 1
log "Touchpad tapping configured."

# Caps Lock to Esc Key Remap
# log "Remapping Caps Lock to Escape key."
# setxkbmap -option caps:escape
# log "Caps Lock remapped to Escape."

# Screenshots
log "Starting flameshot for screenshots."
flameshot &
log "Flameshot started."

# Notifications
log "Starting dunst for notifications."
dunst &
log "Dunst started."

# Compositor
log "Starting picom compositor."
picom -f &
log "Picom compositor started."

# Start ssh-agent if it's not already running
log "Checking for running ssh-agent."
if ! pgrep -u $USER ssh-agent > /dev/null; then
    log "Starting new ssh-agent."
    eval $(ssh-agent -s)
    # Optionally, add your SSH key(s) if desired
    # ssh-add /path/to/your/private_key
    log "ssh-agent started."
else
    log "ssh-agent is already running."
fi

# turning the screen from turning off
log "turning the screen saver off"
xset s off
xset -dpms
log "screen saver turned off"
# Emacs
log "Starting Emacs daemon."
/usr/bin/emacs --daemon &
log "Emacs daemon started."

# Test (optional log entry for testing purpose)
log "Test log entry for verification."

# End of the script
log "autostart.sh script completed."
