#!/bin/bash

set -e

################################

timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}

TIMESTAMP_VAL=$(timestamp)

################################

## https://abdullah.today/encrypted-dotfiles/
## https://www.linode.com/docs/security/encryption/gpg-keys-to-send-encrypted-messages/
## https://unix.stackexchange.com/questions/481939/how-to-export-a-gpg-private-key-and-public-key-to-a-file
## https://github.com/DDoSolitary/LxRunOffline/issues/75
## https://serverfault.com/questions/525805/getting-errors-while-making-backup-of-whole-centos-with-tar
## https://superuser.com/questions/1075404/how-can-i-restart-gpg-agent/1150399
## https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/
## https://superuser.com/questions/1493404/bash-function-gives-command-not-found-when-used-within-a-bash-script

################################

FILE_TO_DECRYPT=""

################################

copy_some_backups() {
  echo "copy a backup of /etc/hosts file..."
  if [[ -e /etc/hosts ]];then
    cp /etc/hosts "$DOTFILES_DIR_LI4NI_MACOS"/etc_hosts_bkps/etc_hosts-bkp-"$TIMESTAMP_VAL"
  else
    echo "/etc/hosts does not exist, skipping..."
  fi
  echo "copy a backup of Brewfile bundle from ~/Brewfile ..."
  ### NOTE: run this command manually first as it takes a lot of time:
  ### brew bundle dump --all --mas --whalebrew --describe
  if [[ -e "$HOME"/Brewfile ]];then
    cp "$HOME"/Brewfile "$DOTFILES_DIR"/macos-dotfiles/_homebrew_brew_cask_brewfile_bundle/Brewfile-bkp-"$TIMESTAMP_VAL"  
  else
    echo "Brewfile does not exist, skipping..."
  fi
  echo "done."
}

################################

en_li4ni() {
  echo "en_li4ni..."
  gpgconf --kill gpg-agent
  tar czf _li4ni_script_generated-"$TIMESTAMP_VAL".tar.gz _li4ni
  gpg -er atkuzmanov@gmail.com _li4ni_script_generated-"$TIMESTAMP_VAL".tar.gz
  rm -rf _li4ni_script_generated-"$TIMESTAMP_VAL".tar.gz
  echo "done."
}
# export -f en_li4ni

################################

# de_li4ni() {
#   gpg -do _li4ni_script_generated.tar.gz _li4ni_script_generated.tar.gz.gpg
#   tar xvf _li4ni_script_generated.tar.gz
#   rm -rf _li4ni_script_generated.tar.gz
# }
# export -f de_li4ni

## https://stackoverflow.com/questions/125281/how-do-i-remove-the-file-suffix-and-path-portion-from-a-path-string-in-bash
## https://stackoverflow.com/questions/12152626/how-can-i-remove-the-extension-of-a-filename-in-a-shell-script/12152997
## https://bash.cyberciti.biz/guide/File_attributes_comparisons
## https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/#:~:text=To%20check%20if%20a%20directory,%2Fto%2Fdir%20exists.%22

de_li4ni() {
  echo "de_li4ni..."
  if [[ -e "$PWD/_li4ni" ]];then
    echo "Another version for _li4ni was found, skipping..."
  else
    gpg -do ${FILE_TO_DECRYPT/.gpg/} "$FILE_TO_DECRYPT"
    tar xvf ${FILE_TO_DECRYPT/.gpg/}
    rm -rf ${FILE_TO_DECRYPT/.gpg/}
  fi
}

################################

## https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash

## A POSIX variable
# OPTIND=1 # Reset in case getopts has been used previously in the shell.
# 
# while getopts "h?ed:" opt; do
#     case "$opt" in
#     e ) en_li4ni
#       ;;
#     d ) 
#       FILE_TO_DECRYPT="$OPTARG"
#       de_li4ni
#       ;;
#     \? ) echo "Usage: cmd [-e] [-d]"
#       ;;
#   esac
# done
# 
# shift $((OPTIND-1))
# [ "${1:-}" = "--" ] && shift

################################

## https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -e|--en_li4ni)
    shift # past argument
    copy_some_backups
    en_li4ni
    ;;
    -d|--de_li4ni)
    FILE_TO_DECRYPT="$2"
    de_li4ni
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

################################
################################
################################


