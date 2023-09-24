#!/bin/bash

# Read the file line-by-line
while read -r package; do
  # Remove leading and trailing whitespaces (if any)
  package=$(echo "$package" | awk '{print $1}')

  # Skip empty lines
  if [ -z "$package" ]; then
    continue
  fi

  # Check if the package is already installed
  if pacman -Q "$package" &>/dev/null; then
    echo "$package is already installed. Skipping..."
  else
    # Install the package
    echo "Installing $package..."
    sudo pacman -S --noconfirm "$package"
  fi
done < "pacman_pcks"

