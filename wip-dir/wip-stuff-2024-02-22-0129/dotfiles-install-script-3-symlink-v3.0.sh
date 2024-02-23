#!/bin/bash

# Check if two directories are provided as arguments
# if [ $# -ne 2 ]; then
#     echo "Usage: $0 <directory1> <directory2>"
#     exit 1
# fi

# directory1="$1"
# directory2="$2"

directory1="/Users/kuzmanov/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles"
directory2="/Users/kuzmanov/dotfiles-w0-home-test-1"

# Check if both arguments are directories
if [ ! -d "$directory1" ] || [ ! -d "$directory2" ]; then
    echo "Error: Both arguments must be directories."
    exit 1
fi

# Create a backup directory with a timestamp
backup_dir="$HOME/backup_dotfiles_bef_syml_$(date '+%Y-%m-%d-%H%M%S')"
mkdir "$backup_dir"

# Iterate over files and folders in the first directory
for file1 in "$directory1"/_[^.]*; do
    # Extract the filename without the path
    filename1=$(basename "$file1")
    # echo "filename1 >>> $filename1"
    # Check if the filename starts with an underscore
    if [[ "$filename1" == _* && "$filename1" != "." && "$filename1" != ".." ]]; then
        # # Iterate over files and folders in the second directory
        
        echo "filename1 >>> $filename1"

        for file2 in "$directory2"/.[^.]*; do
            echo "file2 << $file2"
            # Extract the filename without the path in the second directory
            filename2=$(basename "$file2")

            # echo "filename2 <<< $filename2"
            # Check if the filename in the second directory starts with a dot
            if [[ "$filename2" == .* && "$filename2" != "." && "$filename2" != ".." ]]; then

                echo "filename2 <<< $filename2"

                # Compare the filenames while ignoring underscore and dot
                if [ "${filename1#_}" == "${filename2#.}" ]; then
                    # Backup the file or folder in the second directory
                    cp -r "$file2" "$backup_dir/"
                    echo "Backup created for $filename2 in $backup_dir"

                    # Remove the file or folder in the second directory
                    rm -r "$file2"

                    # Create a symlink in the second directory with dot instead of underscore
                    ln -s "$file1" "$directory2/${filename1/_/.}"
                    echo "Symlink created for $filename1 in $directory2"
                fi
            fi

        # fi
        done
    fi
done

echo "Script execution completed."



