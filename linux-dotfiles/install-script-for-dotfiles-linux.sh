#!/bin/bash

set -e

####################

timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}

TIMESTAMP_VAR=$(timestamp)

####################


symlink_dirs_linux_specific() {
    echo "symlink_dirs_linux_specific..."
    test -h $HOME/.fonts/fontconfig/fonts.conf || ln -sf $PWD/_fonts.conf $HOME/.fonts/fontconfig/fonts.conf
    test -h $HOME/.awesome || ln -sf $PWD/awesome $HOME/.awesome
    test -h $HOME/.compton.conf || ln -sf $PWD/_compton.conf $HOME/.compton.conf
}
# symlink_dirs_linux_specific

####################

####################
####################
####################


