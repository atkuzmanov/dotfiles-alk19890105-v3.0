#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" | tee -a install_log.txt
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
brew update | tee -a install_log.txt

# Specify the path to your Brewfile
BREW_BUNDLE_FILE="/path/to/your/Brewfile"

# Specify the log file path
LOG_FILE="install_log.txt"

# Install software programs from Brewfile using brew bundle
brew bundle --file="$BREW_BUNDLE_FILE" 2>&1 | tee -a "$LOG_FILE"

# Check for any installation failures and log them
if [ $? -ne 0 ]; then
  echo "Installation completed with errors. Check $LOG_FILE for details."
else
  echo "Installation completed successfully."
fi



