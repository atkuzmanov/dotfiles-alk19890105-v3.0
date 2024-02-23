#!/bin/bash

# Set the source and backup directories
source_dir="$HOME"
backup_dir="$HOME/dotfiles_backup_bef_install_$(date +'%Y-%m-%d-%H%M%S')"

# Create backup directory
mkdir -p "$backup_dir"

# Copy dot files and folders to backup directory, excluding .Trash and .DS_Store
find "$source_dir" -maxdepth 1 -type f -name '.*' ! -name '.Trash' ! -name '.DS_Store' -exec cp {} "$backup_dir" \;
find "$source_dir" -maxdepth 1 -type d -name '.*' ! -name '.Trash' ! -name '.DS_Store' -exec cp -r {} "$backup_dir" \;

# Rename dot files and folders in backup directory
cd "$backup_dir" || exit

for file in .*; do
    if [ "$file" != "." ] && [ "$file" != ".." ]; then
        new_name=$(echo "$file" | sed 's/^\./_/')
        mv "$file" "$new_name"
    fi
done

echo "Backup completed successfully in $backup_dir"


