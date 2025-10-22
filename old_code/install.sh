#!/bin/bash

echo "========================================"
echo "AE Quick Console Plugin Installer"
echo "========================================"
echo

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_NAME="AE_QuickConsole_Plugin"

echo "Installing AE Quick Console Plugin..."
echo

# Define CEP extensions directory
CEP_DIR="/Library/Application Support/Adobe/CEP/extensions"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges."
    echo "Please run with: sudo ./install.sh"
    exit 1
fi

# Create CEP extensions directory if it doesn't exist
if [ ! -d "$CEP_DIR" ]; then
    echo "Creating CEP extensions directory..."
    mkdir -p "$CEP_DIR"
fi

# Copy plugin to CEP extensions directory
echo "Copying plugin files..."
cp -R "$SCRIPT_DIR" "$CEP_DIR/$PLUGIN_NAME"

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "Installation completed successfully!"
    echo "========================================"
    echo
    echo "The AE Quick Console plugin has been installed."
    echo
    echo "To use the plugin:"
    echo "1. Restart After Effects"
    echo "2. Go to Window > Extensions > AE Quick Console"
    echo
    echo "If the plugin doesn't appear, you may need to:"
    echo "1. Enable unsigned extensions in After Effects"
    echo "2. Add the following to your terminal:"
    echo "   defaults write com.adobe.CSXS.9 PlayerDebugMode 1"
    echo
else
    echo
    echo "========================================"
    echo "Installation failed!"
    echo "========================================"
    echo
    echo "There was an error copying the plugin files."
    echo "Please check the permissions and try again."
    echo
fi

echo "Press any key to exit..."
read -n 1

