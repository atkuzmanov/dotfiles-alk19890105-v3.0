#!/bin/bash

# # Specify the directory path
# directory_path="/Users/kuzmanov/dotfiles-w0-home-test-1"
# directory_path2=/Users/kuzmanov/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles

# # Check if the specified directory exists
# if [ ! -d "$directory_path" ]; then
#   echo "Error: Directory not found!"
#   exit 1
# fi

# # Iterate over all files in the directory
# for file in "$directory_path"/.[^.]*; do
  
# echo "$file"
#   # Extract the filename from the path
#   filename=$(basename "$file")


#   # Check if the file is a dotfile
#   if [[ "$filename" == .* && "$filename" != "." && "$filename" != ".." ]]; then
#     echo "Dotfile: $filename"
#   else
#     echo "Not a dotfile: $filename"
#   fi
# done


# #!/bin/bash

# # Specify the directory path
# directory_path2=/Users/kuzmanov/Documents/My-info-files/Atk-Hranilishta-za-kod/dotfiles-w0-test-1/macos-work1-dotfiles

# # Check if the specified directory exists
# if [ ! -d "$directory_path2" ]; then
#   echo "Error: Directory not found!"
#   exit 1
# fi

# # Iterate over all files in the directory
# for file in "$directory_path2"/_[^.]*; do
  
# echo "$file"
#   # Extract the filename from the path
#   filename=$(basename "$file")


#   # Check if the file is a dotfile
#   if [[ "$filename" == _* && "$filename" != "." && "$filename" != ".." ]]; then
#     echo "Dotfile: $filename"
#   else
#     echo "Not a dotfile: $filename"
#   fi
# done



            # Iterate over files and folders in the second directory
        # for file2 in "$directory2"/.[^.]*; do
        #     # Check if the current file exists
        #     if [ -e "$file2" ]; then
        #         echo "file2 << $file2"
        #         # Extract the filename without the path in the second directory
        #         filename2=$(basename "$file2")



#!/bin/bash

directory2="/Users/kuzmanov/dotfiles-w0-home-test-1"

for file2 in "$directory2"/.[^.]*; do
            echo "file2 << $file2"
            # Extract the filename without the path in the second directory
            filename2=$(basename "$file2")
            echo "filename2 <<< $filename2"
done

