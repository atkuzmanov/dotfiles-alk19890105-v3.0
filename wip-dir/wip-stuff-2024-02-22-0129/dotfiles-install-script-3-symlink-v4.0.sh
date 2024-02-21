#!/bin/bash

directory1=/Users/kuzmanov/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles
directory2=/Users/kuzmanov/dotfiles-w0-home-test-1

# Check if both arguments are directories
if [ ! -d "$directory1" ] || [ ! -d "$directory2" ]; then
    echo "Error: Both arguments must be directories."
    exit 1
fi

# Create a backup directory with a timestamp
backup_dir="$HOME/backup_dotfiles_bef_syml_$(date '+%Y-%m-%d-%H%M%S')"
mkdir "$backup_dir"

# Iterate over files and folders in the first directory
for file1 in "$directory1"/* .[^.]*; do

    echo "file1 >>> $file1"
    # # Extract the filename without the path
    # filename1=$(basename "$file1")
    # echo "filename1 >>> $filename1"

            for file2 in "$directory2"/* .[^.]*; do
            # Check if the current file exists
            # echo "file2 << $file2"
                # Extract the filename without the path in the second directory
                filename2=$(basename "$file2")
                echo  "filename2 <<< $filename2"

        done

done
