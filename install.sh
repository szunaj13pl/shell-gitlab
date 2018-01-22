#!/bin/bash

# Janusz Ładecki <szunaj13pl@gmail.com>
# Created on 22.01.2018

function install_gitlab(){
    
    # Create tempormaly folder for clean instalation
    
    local temp_gitlab_folder=$(mktemp -d /tmp/gitlab.XXXXXX)
    
    
    # Download project
    
    git clone https://github.com/szunaj13pl/shell-gitlab.git "$temp_gitlab_folder"\
    && cd "$temp_gitlab_folder"
    
    
    # Create '.bin' folder and copy script to it
    
    mkdir -p $HOME/.bin
    cp gitlab $HOME/.bin
    
    
    # Add '.bin' folder to $PATH
    
    echo "$PATH"| grep --quiet $HOME/.bin\
    && echo 'PATH="$HOME/.bin:$PATH"' >> $HOME/.profile
    
    
    # Create configuration folder and copy 'default_config' to it
    
    mkdir -p $HOME/.config/gitlab
    cp default_config $HOME/.config/gitlab/default_config
    cp --no-clobber default_config $HOME/.config/gitlab/config
    
    # Now you can use 'gitlab' like command
    
    
    # Clean-up
    
    rm -rf "$temp_gitlab_folder"
}

install_gitlab && echo "Now you can use 'gitlab' like command"