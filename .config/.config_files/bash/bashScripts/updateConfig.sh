#!/bin/bash

# Get current directory
CURRENT_DIR=$(pwd)

# Destination paths
BASHRC_DEST="$HOME/.bashrc"
XINITRC_DEST="$HOME/.xinitrc"
I3_CONFIG_DEST="$HOME/.config/i3/config"

# Source paths (relative to current directory)
BASHRC_SRC="$CURRENT_DIR/../.bashrc"
XINITRC_SRC="$CURRENT_DIR/../../.xinitrc"
I3_CONFIG_SRC="$CURRENT_DIR/../../../i3/config"  # Fixed this line
# Create backup function
create_backup() {
    local file=$1
    if [ -f "$file" ]; then
        echo "Creating backup of $file"
        cp "$file" "${file}.bak"
    fi
}

# Check if source files exist
if [ ! -f "$BASHRC_SRC" ]; then
    echo "Error: Source .bashrc not found at $BASHRC_SRC"
    exit 1
fi

if [ ! -f "$XINITRC_SRC" ]; then
    echo "Error: Source .xinitrc not found at $XINITRC_SRC"
    exit 1
fi

if [ ! -f "$I3_CONFIG_SRC" ]; then
    echo "Error: Source i3 config not found at $I3_CONFIG_SRC"
    exit 1
fi

# Create destination directories if they don't exist
mkdir -p "$(dirname "$I3_CONFIG_DEST")"

# Create backups
create_backup "$BASHRC_DEST"
create_backup "$XINITRC_DEST"
create_backup "$I3_CONFIG_DEST"

# Copy files
echo "Copying .bashrc..."
cp "$BASHRC_SRC" "$BASHRC_DEST"

echo "Copying .xinitrc..."
cp "$XINITRC_SRC" "$XINITRC_DEST"

echo "Copying i3 config..."
cp "$I3_CONFIG_SRC" "$I3_CONFIG_DEST"

echo "Files copied successfully!"