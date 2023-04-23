#!/bin/bash

# Check if Plex Media Server is installed
if ! dpkg -l | grep -q plexmediaserver; then
    echo "Plex Media Server is not installed. Exiting."
    exit 1
fi

# Update system
echo "Updating system..."
sudo apt-get update
sudo apt-get upgrade -y

# Add Plex repository if not already added
if [ ! -f "/etc/apt/sources.list.d/plexmediaserver.list" ]; then
    echo "Adding Plex repository..."
    wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -
    echo "deb https://downloads.plex.tv/repo/deb/ public main" | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
    sudo apt-get update
fi

# Upgrade Plex Media Server
echo "Upgrading Plex Media Server..."
sudo apt-get install --only-upgrade -y plexmediaserver

# Print the upgrade status
if [ $? -eq 0 ]; then
    echo "Plex Media Server has been successfully upgraded!"
else
    echo "An error occurred during the upgrade. Please check the logs for more information."
fi
