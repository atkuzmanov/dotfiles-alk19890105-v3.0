#!/bin/bash

set -e

################################



install_xcode_command_line_tools () {
    echo "install_xcode_command_line_tools..."
    if xcode-select --print-path &>/dev/null; then
        echo "XCode command line tools already installed."
    elif xcode-select --install &>/dev/null; then
        echo "Finished installing XCode command line tools."
    else
        echo "Failed to install XCode command line tools!"
    fi
    echo -e "\n####################################\n"
}

# install_xcode_command_line_tools



################################



timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}

TIMESTAMP_VAL=$(timestamp)

echo -e "\033[34mTIMESTPAMP: [:$TIMESTAMP_VAL:]\033[0m \n"

echo -e "\n####################################\n"

################################



### environment variables defined elsewhere

export UNDERSCOREFILES_DIR="$HOME/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles"
echo -e "UNDERSCOREFILES_DIR: > $UNDERSCOREFILES_DIR \n"

export SYMLINK_TARGET_DIR="$HOME/dotfiles-w0-home-test-2"
echo -e "SYMLINK_TARGET_DIR: > $SYMLINK_TARGET_DIR \n"

export DOTFILES_BKPS_DIR="$UNDERSCOREFILES_DIR/dotfiles_BKPS_dir"
echo -e "DOTFILES_BKPS_DIR: > $DOTFILES_BKPS_DIR \n"

export DOTFILES_BKP_BEF_SCRIPT_DIR="$DOTFILES_BKPS_DIR/dotfiles-bkp-bef-SCRIPT-$TIMESTAMP_VAL"
echo -e "DOTFILES_BKP_BEF_SCRIPT_DIR: > $DOTFILES_BKP_BEF_SCRIPT_DIR \n"

export UNDERSCOREFILES_BKP_BEF_SCRIPT_DIR="$DOTFILES_BKPS_DIR/underscorefiles-bkp-bef-SCRIPT-$TIMESTAMP_VAL"
echo -e "UNDERSCOREFILES_BKP_BEF_SCRIPT_DIR: > $UNDERSCOREFILES_BKP_BEF_SCRIPT_DIR \n"

# Define the dotfiles_ignore_list as an array of example file names
dotfiles_ignore_list=(".vscode" ".docker" ".anaconda" ".conda" ".cache" ".thumbnails")

# Define the underscore_ignore_list as an array of example file names
underscore_ignore_list=("_vscode" "_docker" "dotfiles_BKPS_dir" "_anaconda" "_conda" "_cache" "_thumbnails")

echo -e "\n####################################\n"

################################



should_skip_file() {
    local n="$1"
    local ignore_list=("${@:2}")

    for ignore_file in "${ignore_list[@]}"; do
        # Remove the first character if it's a dot or underscore
        local n_pattern=${n#[._]}
        local ignore_file_pattern=${ignore_file#[._]}

        if [[ "$n_pattern" == *"$ignore_file_pattern" ]]; then
            echo -e "\033[35mshould_skip_file() >\033[0m Skipping file in *_ignore_list: $n \n"
            return 0  # File should be skipped
        fi
    done

    return 1  # File should not be skipped
}



################################



backup_dotfiles() {
    echo -e "\033[32mbackup_dotfiles() >\033[0m Backing up dotfiles... \n"
    
    ## create dotfiles_bkp
    echo -n "\033[32mbackup_dotfiles() >\033[0m Creating $DOTFILES_BKP_BEF_SCRIPT_DIR for backup of any existing current dotfiles in ~ ..."
    # echo -e "Creating $DOTFILES_BKP_BEF_SCRIPT_DIR for backup of any existing current dotfiles in ~ ... \n"
    mkdir -p $DOTFILES_BKP_BEF_SCRIPT_DIR
    echo -e "Done. \n"
    
    ## copy current dotfiles in bkp dir
    
    declare -a CURRENT_DOTFILES_ARRAY
    while IFS=  read -r -d '' n; do

        if should_skip_file "$n" "${dotfiles_ignore_list[@]}"; then
            # echo -e "backup_dotfiles() > Skipping dotfile in dotfiles_ignore_list: $n \n"
            continue  # Skip the file
        fi

        if ! [[ "$n" =~ .*"Trash".* || "$n" =~ .*"DS_Store".* ]]; then
          if [ "$n" != "." ] && [ "$n" != ".." ]; then
            CURRENT_DOTFILES_ARRAY+=("$n")
          fi
        fi
      
    done < <(find "$HOME" -mindepth 1 -maxdepth 2 -name ".*" ! -type l -print0)
    
    
    for current_dotfile in "${CURRENT_DOTFILES_ARRAY[@]}" ;
    do
      sudo cp -r "$current_dotfile" $DOTFILES_BKP_BEF_SCRIPT_DIR
      # echo -e "\033[32mbackup_dotfiles() >\033[0m current_dotfile: $current_dotfile \n"
    done

    echo -e "\n\033[32m####################################\033[0m \n"
}

backup_dotfiles



################################



rename_backup_dotfiles() {
    echo -e "\033[31mrename_backup_dotfiles() >\033[0m Rename_backup_dotfiles... \n"
    
    cd "$DOTFILES_BKP_BEF_SCRIPT_DIR"
    
    for file in .[^.]* ; do
      test -e "$file" &&
        sudo mv "$file" "_${file//.}"
    done
    
    cd ~

    echo -e "\n\033[31m####################################\033[0m\n"
}

rename_backup_dotfiles 



################################



symlink_dotfiles() {
    echo -e "\033[34msymlink_dotfiles() >\033[0m symlink_dotfiles... \n"

    # Create a backup directory with a timestamp
    DOTFILES_BKP_BEF_SYMLINK_DIR="$DOTFILES_BKPS_DIR/dotfiles_bkp_bef_SYML_$(timestamp)"
    echo -n "\033[34msymlink_dotfiles() >\033[0m Creating $DOTFILES_BKP_BEF_SYMLINK_DIR for backup of any existing current dotfiles in ~ ..."
    mkdir -p $DOTFILES_BKP_BEF_SYMLINK_DIR
    echo -e "Done. \n"

    cd $UNDERSCOREFILES_DIR

    for x in _*;do      

      echo "X: $x"

        actual_file=${x/_/.}
        symlink_target="$SYMLINK_TARGET_DIR"/"${actual_file}"

        # echo -e "symlink_dotfiles() > symlink_target: $symlink_target \n"

      if ! [[ "$actual_file" =~ .*"Trash".* || "$actual_file" =~ .*"DS_Store".* && "$actual_file" == "." && "$actual_file" == ".." ]]; then
        
        if [[ -h "$symlink_target" ]];then
          echo -e "\033[34msymlink_dotfiles() >\033[0m Another version for symlink of $actual_file was found, skipping... \n"

        elif [[ -e "$symlink_target" && "${x#_}" == "${actual_file#.}"  ]]; then

          echo -e "s\033[34mymlink_dotfiles() >\033[0m Another version for $actual_file was found, skipping... \n"

          echo -e "\033[34msymlink_dotfiles() >\033[0m Copying "$symlink_target" to "$DOTFILES_BKP_BEF_SYMLINK_DIR/${actual_file/./_}" \n"

          sudo cp -r "$symlink_target" "$DOTFILES_BKP_BEF_SYMLINK_DIR/${actual_file/./_}"

          echo -e "\033[34msymlink_dotfiles() >\033[0m Deleting ${symlink_target} \n"

          sudo rm -rf ${symlink_target}

          echo -e "\033[34msymlink_dotfiles() >\033[0m Symlinking > "$UNDERSCOREFILES_DIR"/"${x}" ---> ${symlink_target} \n"
          
          ## Always have "$PWD" and other variables which contain directories with spaces for that matter in quotes.
          
          sudo ln -sf "$UNDERSCOREFILES_DIR"/"${x}" "${symlink_target}"
        
        else

          echo -e "\033[34msymlink_dotfiles() >\033[0m Symlinking > "$UNDERSCOREFILES_DIR"/"${x}" ---> ${symlink_target} \n"

          ## Always have "$PWD" and other variables which contain directories with spaces for that matter in quotes.
          
          sudo ln -sf "$UNDERSCOREFILES_DIR"/"${x}" "${symlink_target}"

      fi

     fi
        
    done

    cd ~

    echo -e "\n\033[34m####################################\033[0m\n"
}


symlink_dotfiles

export UNDERSCOREFILES_DIR="$HOME/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles/_li4ni"

symlink_dotfiles

export UNDERSCOREFILES_DIR="$HOME/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles"

cd ~



################################



backup_underscorefiles() {
    echo -e "\033[33;91mbackup_underscorefiles() >\033[0m Backing up underscorefiles... \n"

    cd "$UNDERSCOREFILES_DIR"

    echo -n "\033[33;91mbackup_underscorefiles() >\033[0m Creating $UNDERSCOREFILES_BKP_BEF_SCRIPT_DIR for backup of any existing current underscorefiles in ~ ... \n"
    mkdir -p $UNDERSCOREFILES_BKP_BEF_SCRIPT_DIR
    echo "done"
    
    ### Copy current underscorefiles in bkp dir.
    
    declare -a CURRENT_UNDERSCOREFILES_ARRAY
    while IFS=  read -r -d '' n; do

      if should_skip_file "$n" "${underscore_ignore_list[@]}"; then
          # echo -e "Skipping underscorefile in underscore_ignore_list: $n \n"
          continue  # Skip the file
      fi

      if ! [[ "$n" =~ .*"Trash".* || "$n" =~ .*"DS_Store".* ]]; then
        if [ "$n" != "." ] && [ "$n" != ".." ]; then
          if [[ ! -h "$n" ]];then
            CURRENT_UNDERSCOREFILES_ARRAY+=("$n")
          fi
        fi
      fi

    done < <(find "$UNDERSCOREFILES_DIR" -mindepth 1 -maxdepth 1 -name "*" ! -type l -print0)
    
    
    for current_underscorefile in "${CURRENT_UNDERSCOREFILES_ARRAY[@]}" ;
    do
      sudo cp -r "$current_underscorefile" $UNDERSCOREFILES_BKP_BEF_SCRIPT_DIR
      # echo $current_underscorefile
    done

    cd ~

    echo -e "\n\033[33;91m####################################\033[0m\n"
}

backup_underscorefiles



################################



zip_bkp_dirs() {
  echo -e "\033[35mzip_bkp_dirs() >\033[0m executing..."

  # Check if the specified directory exists
  if [ ! -d "$DOTFILES_BKPS_DIR" ]; then
      echo -e "\033[35mzip_bkp_dirs() >\033[0m Error: Specified directory does not exist. \n"
      exit 1
  fi

  cd $DOTFILES_BKPS_DIR

  directory_path="$DOTFILES_BKPS_DIR"

  # echo -e "zip_bkp_dirs() > directory_path: $directory_path \n"

  # Loop through each subdirectory and create a separate archive for each
  for subdirectory in "$directory_path"/*/; do
      subdirectory_name=$(basename "$subdirectory")
      archive_filename="archive_${subdirectory_name}_${TIMESTAMP_VAL}.tar.gz"
      sudo tar -czf "$archive_filename" -C "$directory_path" "$subdirectory_name"
      echo -e "\033[35mzip_bkp_dirs() >\033[0m Archive created for $subdirectory_name: $archive_filename \n"
      echo -e "\033[35mzip_bkp_dirs() >\033[0m Deleting $subdirectory_name \n"
      sudo rm -rf $subdirectory_name
  done

  cd ~

  echo -e "\n\033[35m####################################\033[0m\n"
}

zip_bkp_dirs



################################

# copy and symlink new dotfiles


copy_and_symlink_new_dotfiles() {
  echo -e "\033[33mcopy_and_symlink_new_dotfiles() >\033[0m Copy and symlink new dotfiles which don't exist in underscorefiles yet... \n"

  cd $SYMLINK_TARGET_DIR

  for y in .*;do      

    actual_file=${y/./_}
    copy_target="$UNDERSCOREFILES_DIR"/"${actual_file}"
    
    # echo -e "copy_and_symlink_new_dotfiles() > y: $y \n"

    if should_skip_file "$y" "${dotfiles_ignore_list[@]}"; then
      continue  # Skip the file
    fi

    # echo -e "copy_and_symlink_new_dotfiles() >  copy_target: $copy_target \n"
    
    # echo -e "copy_and_symlink_new_dotfiles() > y: $y \n"

    # echo -e "copy_and_symlink_new_dotfiles() > basename: $(basename "${copy_target}" | sed 's/^_//')"

    if [[ -e "$copy_target" && "${y#.}" == $(basename "${copy_target}" | sed 's/^_//')  ]]; then
      echo -e "\033[33mcopy_and_symlink_new_dotfiles() >\033[0m Skipping copy target because it exists: $copy_target \n"
      continue  # Skip the file
    else
      
      copy_target_li4ni="$UNDERSCOREFILES_DIR"/_li4ni/"${actual_file}"

      if [[ -e "$copy_target_li4ni" && "${y#.}" == $(basename "${copy_target_li4ni}" | sed 's/^_//')  ]]; then
        echo -e "\033[33mcopy_and_symlink_new_dotfiles() >\033[0m Skipping copy target because it exists in _li4ni: $copy_target_li4ni \n"
        continue  # Skip the file
      fi
    
    fi


    if ! [[ "$y" =~ .*"Trash".* || "$y" =~ .*"DS_Store".* ]]; then
      if [ "$y" != "." ] && [ "$y" != ".." ]; then
        if [[ ! -h "$y" ]];then
          
          # echo -e "copy_and_symlink_new_dotfiles() > y: $y \n"

          echo -e "\033[33mcopy_and_symlink_new_dotfiles() >\033[0m Copying > "$y" ---> "$UNDERSCOREFILES_DIR/${y/./_}" \n"

          sudo cp -r "$y" "$UNDERSCOREFILES_DIR/${y/./_}"

          echo -e "\033[33mcopy_and_symlink_new_dotfiles() >\033[0m Deleting "$SYMLINK_TARGET_DIR/${y}" \n"

          sudo rm -rf "$SYMLINK_TARGET_DIR/${y}"

          echo -e "\033[33mcopy_and_symlink_new_dotfiles() >\033[0m Symlinking > "$copy_target" ---> "$SYMLINK_TARGET_DIR/${y}" \n"

          sudo ln -sf "$copy_target" "$SYMLINK_TARGET_DIR/${y}"

        fi
      fi
    fi

  done

  cd ~

  echo -e "\n\033[33m####################################\033[0m\n"
}

copy_and_symlink_new_dotfiles



################################



# Function to show sizes of files and folders in a directory

show_sizes() {

  echo -e "\033[94mshow_sizes() >\033[0m Executing... \n"

  local directory_path="$1"

  # Check if the specified directory exists
  if [ -d "$directory_path" ]; then
      # Use find command to get the sizes of all files and folders in KB, limited to the specified directory
      
      # sizes=$(find "$directory_path" -maxdepth 1 -exec du -B1 {} + | sort -n -r)
      # sizes=$(find "$directory_path" -mindepth 1 -maxdepth 1 -exec du -B1 {} \; | sort -n -r)
      # sizes=$(find "$directory_path" -mindepth 1 -maxdepth 1 \( -type f -o -type d -o -type l \) -exec du -B1 {} \; | sort -n -r)
      # sizes=$(find "$directory_path" -mindepth 1 -maxdepth 1 \( -type f -o -type d -o -type l \) -exec du -B1 {} + -o -name "$(basename "$directory_path")" -prune | sort -n -r)

      # sizes=$(find "$directory_path" -maxdepth 1 -mindepth 1 -exec du -sB1 {} \; | sort -n -r)
      sizes=$(find "$directory_path" -maxdepth 1 -mindepth 1 -exec du -sB1 {} + | sort -n -r)

      # Display sizes and highlight any size more than 50MB
      echo -e "\033[94mFile/Folder\tSize (MB)\033[0m \n"
      echo -e "\033[94m------------------------------------\033[0m \n"
      echo "$sizes" | while read -r line; do
          size=$(echo "$line" | awk '{print $1}')
          item=$(echo "$line" | cut -f2-)

          # Convert sizes to MB and highlight sizes more than 50MB
          size_in_mb=$(awk "BEGIN {printf \"%.2f\", $size/1024}")
          if (( $(echo "$size_in_mb > 50" | bc -l) )); then
              echo -e "\033[31m$item\t$size_in_mb MB\033[0m"
          else
              echo -e "$item\t$size_in_mb MB"
          fi
      done
  else
      echo -e "\033[94mshow_sizes() >\033[0m Directory not found: $directory_path \n"
  fi
  
  echo -e "\n\033[91m####################################\033[0m\n"
}

# Example usage
# directory_to_check="/path/to/your/directory"
# show_sizes "$directory_to_check"

show_sizes "$UNDERSCOREFILES_DIR"




################################



