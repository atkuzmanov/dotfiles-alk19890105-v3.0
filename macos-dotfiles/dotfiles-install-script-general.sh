#!/bin/bash

set -e

################################

## environment variables defined elsewhere

################################

## Absolute path to this script, e.g. /Users/foo/bin/bar.sh
# SCRIPT=$(greadlink -f $0)
# Absolute path this script is in, е.g. /Users/foo/bin
# SCRIPTPATH=$(dirname $SCRIPT)

################################

timestamp() {
  date +"%Y-%m-%d-%H%M%S"
}

TIMESTAMP_VAL=$(timestamp)

################################
## https://github.com/michaeljsmalley/dotfiles
## todo: to be broken off in a separate script

backup_dotfiles() {
    echo "backup_dotfiles..."
    BKP_DOTFILES_DIR=~/dotfiles-bkp-$(timestamp)
    
    ## create dotfiles_old in homedir
    echo -n "Creating $BKP_DOTFILES_DIR for backup of any existing current dotfiles in ~ ..."
    mkdir -p $BKP_DOTFILES_DIR
    echo "done"
    
    ## copy current dotfiles in bkp dir
    
    ## https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
    ## https://stackoverflow.com/questions/26475358/negate-if-condition-in-bash-script
    ## https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php
    
    declare -a CURRENT_DOTFILES_ARRAY
    while IFS=  read -r -d '' n; do
    	if ! [[ "$n" =~ .*"Trash".* || "$n" =~ .*"DS_Store".* ]]; then
        	CURRENT_DOTFILES_ARRAY+=("$n")
        fi
    done < <(find "$HOME" -mindepth 1 -maxdepth 2 -name ".*" ! -type l -print0)
    
    
    for current_dotfile in "${CURRENT_DOTFILES_ARRAY[@]}" ;
    do
    	cp -r "$current_dotfile" $BKP_DOTFILES_DIR
    	# echo $current_dotfile
    done
}
# backup_dotfiles

#####

## rename files in bkp dir by replacing the dot with an underscore, so that they become visible

## https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
## https://linuxize.com/post/bash-printf-command/
## https://zone.ni.com/reference/en-XX/help/371361R-01/lvconcepts/format_specifier_syntax/
## http://tldp.org/LDP/abs/html/string-manipulation.html
## https://unix.stackexchange.com/questions/104881/remove-particular-characters-from-a-variable-using-bash

rename_backup_dotfiles() {
    echo "rename_backup_dotfiles..."
    cd "$BKP_DOTFILES_DIR"
    
    for file in .[^.]* ; do
    	test -e "$file" &&
    		sudo mv "$file" "_${file//.}"
    done
    
    cd ~
}
# rename_backup_dotfiles 

################################

## TODO WIP
install_software() {
    echo "install_software..."
    ### macos
    
    ## install homebrew
    if [[ $(command -v brew) == "" ]]; then
        echo "Installing Hombrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "Updating Homebrew"
        brew update
    fi
    
    ## https://docs.brew.sh/Manpage#bundle-subcommand
    brew bundle --file="_homebrew_brew_cask_brewfile_bundle/Brewfile"
    
    ##########

    ### linux debian
    
    ## TODO WIP

    # apt-get install git
}
# install_software

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
}
# install_xcode_command_line_tools

################################

## fonts needed for zsh, oh-my-zsh, antigen themes
## https://github.com/ohmyzsh/ohmyzsh/issues/1906#issuecomment-252443982
install_powerline_fonts() {
    echo "install_powerline_fonts..."
    cd "$DOTFILES_DIR"
    # clone
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ~
}
# install_powerline_fonts

################################

# activate cdable_vars
# shopt -s cdable_vars

install_zsh_oh_my_zsh_antigen () {
    echo "install_zsh_oh_my_zsh_antigen..."
    cd "$DOTFILES_DIR"
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        # Clone my oh-my-zsh repository from GitHub only if it isn't already present
        if [[ ! -d "$DOTFILES_DIR"/_oh-my-zsh/ ]]; then
            git clone https://github.com/ohmyzsh/ohmyzsh.git _oh-my-zsh
        fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
            chsh -s $(which zsh)
        fi
    else
        # If zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # If the platform is Linux, try an apt-get to install zsh and then recurse
        if [[ $platform == 'Linux' ]]; then
            if [[ -f /etc/debian_version ]]; then
                sudo apt-get install zsh
                sudo apt-get install zsh-antigen
                install_zsh_oh_my_zsh_antigen
            fi
        # If the platform is OS X, tell the user to install zsh :)
        elif [[ $platform == 'Darwin' ]]; then
            brew install zsh
            brew install antigen
            install_zsh_oh_my_zsh_antigen
        fi
    fi

    cd ~
}
# install_zsh_oh_my_zsh_antigen

################################

## symlinks

symlink_dotfiles() {
    echo "symlink_dotfiles..."
    for x in _*;do
        actual_file=${x/_/.}
        symlink_target="$HOME"/"${actual_file}"
        
        if [[ -h "$HOME"/"$actual_file" ]];then
            echo "Another version for $actual_file was found, skipping"
        else
           # rm ${symlink_target}
           echo "Creating symlink at ${symlink_target} ..."
           ## Always have "$PWD" and other variables which contain directories with spaces for that matter in quotes.
           ln -sf "$PWD"/"${x}" "${symlink_target}"
        fi
    done
}
# symlink_dotfiles
# cd _li4ni/
# symlink_dotfiles
# cd macos-dotfiles/
# symlink_dotfiles

symlink_dirs() {
    echo "symlink_dirs..."
    test -h "$HOME"/bin || ln -sf $PWD/bin "$HOME"/bin
    # test -h "$HOME"/.oh-my-zsh || ln -sf "$DOTFILES_DIR"/_antigen/bundles/robbyrussell/oh-my-zsh ~/.oh-my-zsh    
    # test -h "$HOME"/Library/Application\ Support/Sublime\ Text\ 3/Packages/User || ln -sf "$DOTFILES_DIR"/_config/user_library_application_support_atk2/Sublime\ Text\ 3/Packages/User "$HOME"/Library/Application\ Support/Sublime\ Text\ 3/Packages
    # test -h "$HOME"/Library/Application\ Support/GIMP || ln -sf "$DOTFILES_DIR"/_config/user_library_application_support_atk2/GIMP "$HOME"/Library/Application\ Support/GIMP
    ## Do the one below for iTerm2 manually from iTerm2's settings
    ## test -h "$HOME"/Library/Application\ Support/iTerm2/com.googlecode.iterm2.plist || ln -sf "$DOTFILES_DIR"/_config/custom_atk2/iterm2_atk2/com.googlecode.iterm2.plist
    ## test -h "$HOME"/.macos || ln -sf "$DOTFILES_DIR"/macos-dotfiles/.macos ~/.macos
}
# symlink_dirs

################################

## TODO WIP
setup_git_hosted_modules () {
    echo "setup_git_hosted_modules..."
    git submodule sync
    git submodule init
    git submodule update
    git submodule foreach git pull origin master
}
# setup_git_hosted_modules

################################

source_some_files () {
    echo "source_some_files..."
    source ~/.macos
}
# source_some_files

################################

## https://github.com/gabrielelana/awesome-terminal-fonts
setup_awesome_fonts() {
    echo "setup_awesome_fonts"
    git clone git clone git@github.com:gabrielelana/awesome-terminal-fonts.git "$WORKSPACE_DIR"
    test -h "$DOTFILES_DIR/_fonts_awesome_terminal_fonts_custom" || mkdir "$DOTFILES_DIR/_fonts_awesome_terminal_fonts_custom"
    cp -r "$WORKSPACE_DIR/awesome-terminal-fonts/build/" "$DOTFILES_DIR/_fonts_awesome_terminal_fonts_custom"
    ln -sf "$DOTFILES_DIR/_fonts_awesome_terminal_fonts_custom ~/.fonts_awesome_terminal_fonts_custom"
    ## add the source command below to .zshrc or .bash_profile
    source ~/.fonts_awesome_terminal_fonts_custom/*.sh
}
# setup_awesome_fonts

################################

## http://beets.io/
## The purpose of beets is to get your music collection right once and for all. 
## It catalogs your collection, automatically improving its metadata as it goes using the MusicBrainz database. 
## Then it provides a bouquet of tools for manipulating and accessing your music.
## http://akeil.net/listings/beets.config.yaml.html
# install_beets() {
    # echo "$pip install beets"
    # pip3 "$install beets"
# }
# install_beets

################################


################################
################################
################################


