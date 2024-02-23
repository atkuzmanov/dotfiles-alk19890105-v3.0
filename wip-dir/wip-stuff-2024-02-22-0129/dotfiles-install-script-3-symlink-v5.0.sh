#!/bin/bash

set -e

################################

timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}

TIMESTAMP_VAL=$(timestamp)

################################

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
backup_dir="$HOME/backup_dotfiles_bef_syml_$TIMESTAMP_VAL"
mkdir "$backup_dir"


declare -a CURRENT_UNDERSCOREFILE_ARRAY
while IFS=  read -r -d '' n; do
    if ! [[ "$n" =~ .*"Trash".* || "$n" =~ .*"DS_Store".* ]]; then
        CURRENT_UNDERSCOREFILE_ARRAY+=("$n")
    fi
done < <(find "$directory1" -mindepth 1 -maxdepth 2 -name "_*" ! -type l -print0)

# for current_underscorefile in "${CURRENT_UNDERSCOREFILE_ARRAY[@]}" ;
# do
#     echo $current_underscorefile
# done


declare -a CURRENT_DOTFILES_ARRAY
while IFS=  read -r -d '' n; do
    if ! [[ "$n" =~ .*"Trash".* || "$n" =~ .*"DS_Store".* ]]; then
        CURRENT_DOTFILES_ARRAY+=("$n")
    fi
done < <(find "$directory2" -mindepth 1 -maxdepth 2 -name ".*" ! -type l -print0)

# for current_dotfile in "${CURRENT_DOTFILES_ARRAY[@]}" ;
# do
#     echo $current_dotfile
# done



for current_underscorefile in "${CURRENT_UNDERSCOREFILE_ARRAY[@]}" ;do
    # echo $current_underscorefile

    filename1=$(basename "$current_underscorefile")

    # Check if the filename starts with an underscore
    if [[ "$filename1" == _* && "$filename1" != "." && "$filename1" != ".." ]]; then

        echo "filename1 >>> >>> $filename1"

        for current_dotfile in "${CURRENT_DOTFILES_ARRAY[@]}" ;do
            # echo $current_dotfile

            filename2=$(basename "$current_dotfile")

            # Check if the filename in the second directory starts with a dot
            if [[ "$filename2" == .* && "$filename2" != "." && "$filename2" != ".." ]]; then

                echo "filename2 < $filename2"

                if [ "${filename1#_}" == "${filename2#.}" ]; then
                    # Backup the file or folder in the second directory and rename with underscore
                    # cp -r "$current_dotfile" "$backup_dir/${filename2/./_}"
                    # echo "Backup created for $filename2 in $backup_dir"

                    continue
                fi

            fi

        done

    fi

done





