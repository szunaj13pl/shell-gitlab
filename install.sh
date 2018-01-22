# Janusz Ładecki <szunaj13pl@gmail.com>
# Created on 22.01.2018

function install_gitlab() {
    
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
    
    local temp_gitlab_folder=$(mktemp -d /tmp/gitlab.XXXXXX)
    
    
    # Download project
    
    git clone https://github.com/szunaj13pl/shell-gitlab.git "$temp_gitlab_folder"\
    && cd "$temp_gitlab_folder"
    
    
    # Create 'bin' folder and copy script to it
    
    mkdir -p $HOME/bin
    cp gitlab $HOME/bin
    
    
    # Add 'bin' folder to $PATH
    
    echo "$PATH"| grep --quiet "$HOME/bin" \
    && echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.profile
    
    
    # Create configuration folder and copy 'default_config' to it
    
    mkdir -p $HOME/.config/gitlab
    cp default_config $HOME/.config/gitlab/default_config
    cp --no-clobber default_config $HOME/.config/gitlab/config
    
    # Now you can use 'gitlab' like command
    
    
    # Clean-up
    
    rm -rf "$temp_gitlab_folder"
}

install_gitlab && echo "Now you can use 'gitlab' like command"