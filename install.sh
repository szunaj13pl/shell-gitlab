#!/bin/bash

# Janusz Ładecki <szunaj13pl@gmail.com>
# Created on 22.01.2018

install_gitlab() {
    
    # Activate RAW version of install script
    hash curl >/dev/null 2>&1 || {
        wget https://github.com/szunaj13pl/shell-gitlab/raw/master/install.sh  2>>/dev/null 1>/dev/null
    } || \
    hash wget >/dev/null 2>&1 || {
        curl https://github.com/szunaj13pl/shell-gitlab/raw/master/install.sh 1>>/dev/null -s
    }
    
    clean
    
    # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi
    
    # Only enable exit-on-error after the non-critical colorization stuff,
    # which may fail on systems lacking tput or terminfo
    set -e
    
    # Create tempormaly folder for clean instalation
    printf "${BLUE}Creating temporary folder${YELLOW} $temp_gitlab_folder ${BLUE}...${NORMAL}\n"
    
    local temp_gitlab_folder=$(mktemp -d /tmp/gitlab.XXXXXX)
    
    
    # Check if git is installed
    printf "${BLUE}Checking if ${YELLOW}git ${BLUE}is installed ...${NORMAL}\n"
    
    hash git >/dev/null 2>&1 || {
        printf "${NORMAL}Error:${YELLOW}git ${RED}is not installed${NORMAL}\n"
        exit 1
    }
    
    
    # Download project
    printf "${BLUE}Cloning ${BOLD}gitlab ${NORMAL}\n"
    
    git clone https://github.com/szunaj13pl/shell-gitlab.git "$temp_gitlab_folder"\
    && cd "$temp_gitlab_folder"
    
    
    # Create 'bin' folder and copy script to it
    
    printf "${BLUE}Checking if ${YELLOW}$HOME/bin${BLUE} exists ...${NORMAL}\n"
    mkdir -p $HOME/bin
    
    printf "${BLUE}Coping ${BOLD}gitlab ${NORMAL}${BLUE}to ${YELLOW}$HOME/bin ${NORMAL}\n"
    cp gitlab $HOME/bin
    
    
    # Add 'bin' folder to $PATH
    printf "${BLUE}Checking if ${YELLOW}$HOME/bin${BLUE} is in PATH ...${NORMAL}\n"
    
    echo "$PATH"| grep --quiet "$HOME/bin" \
    && (echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.profile && printf "${GREEN} Adding ${YELLOW}$HOME/bin${GREEN} to PATH ...${NORMAL}\n")
    
    
    # Create configuration folder and copy 'default_config' to it
    printf "${BLUE}Looking for an existing gitlab config...${NORMAL}\n"
    mkdir -p $HOME/.config/gitlab
    cp default_config $HOME/.config/gitlab/default_config
    cp --no-clobber default_config $HOME/.config/gitlab/config
    
    # Now you can use 'gitlab' like command
    
    
    # Clean-up
    printf "${BLUE}Cleaning...${NORMAL}\n"
    
    rm -rf "$temp_gitlab_folder"
}

install_gitlab && printf "${BLUE}Now you can use like ${YELLOW}gitlab ${BLUE}command${NORMAL}\n"