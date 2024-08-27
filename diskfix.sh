#!/bin/bash

# Define the file path
FILE="/usr/lib/node_modules/rivalz-node-cli/node_modules/systeminformation/lib/filesystem.js"

# Function to find the correct file path
find_file_path() {
  local search_path="$1"
  find "$search_path" -type f -name "filesystem.js" 2>/dev/null | grep "systeminformation/lib/filesystem.js" | head -n 1
}

# Check if the file exists
if [ ! -f "$FILE" ]; then
  echo "File not found at $FILE. Attempting to locate it..."
  FILE=$(find_file_path "/usr/lib")

  if [ -z "$FILE" ]; then
    FILE=$(find_file_path "/usr/local/lib")
  fi

  if [ -z "$FILE" ]; then
    FILE=$(find_file_path "/opt")
  fi

  if [ -z "$FILE" ]; then
    # Adding check for ~/.nvm path
    FILE=$(find_file_path "$HOME/.nvm")
  fi

  if [ -z "$FILE" ]; then
    echo "Error: filesystem.js not found. Make sure npm is installed and the file path is correct."
    exit 1
  fi

  echo "File found at $FILE"
fi

# Create a temporary file
TMP_FILE=$(mktemp)

# Define the original line and the replacement line
ORIGINAL_LINE="devices = outJSON.blockdevices.filter(item => { return (item.type === 'disk') && item.size > 0 && (item.model !== null || (item.mountpoint === null && item.label === null && item.fstype === null && item.parttype === null && item.path && item.path.indexOf('/ram') !== 0 && item.path.indexOf('/loop') !== 0 && item['disc-max'] && item['disc-max'] !== 0)); });"
NEW_LINE="devices = outJSON.blockdevices.filter(item => { return (item.type === 'disk') && item.size > 0 }).sort((a, b) => b.size - a.size);"

# Read through the file line by line
while IFS= read -r line
do
  if [[ "$line" == *"$ORIGINAL_LINE"* ]]; then
    echo "$NEW_LINE" >> "$TMP_FILE"
  else
    echo "$line" >> "$TMP_FILE"
  fi
done < "$FILE"

# Replace the original file with the modified one
mv "$TMP_FILE" "$FILE"
