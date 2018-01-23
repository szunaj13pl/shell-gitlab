# Gitlab in shell 

Search and clone Gitlab project directly from shell with nice and clean GUI.

Clone selected projects to current directory.


## Usage 

`gitlab <string>` - Return list of projects matching the search criteria

`gitlab -c` - Edit configuration

`gitlab -d` - Enable debuging mode 

## Configuration

Run `gitlab -c` to edit configuration __~/.config/gitlab/config__

|variable name          |value      |exemple                                                  |  
|----------------------|------------|---------------------------------------------------------|
|`autoupdate`|(default) true <br> _Check update once prer day_|`autoupdate=true`|
|`GITLAB_URL`| Gitlab HTTPS address |`GITLAB_URL=gitlab.company.com`|
|`GITLAB_PRIVATE_TOKEN`| Personal Access Token <br> Scopes **api** (Access your API)<br><br>  *https://<GITLAB_URL>/profile/personal_access_tokens*|`GITLAB_PRIVATE_TOKEN=verySecretToken123`|



## Requrments


|   command                                             |      description                                                  |
|-------------------------------------------------------|-------------------------------------------------------------------|
|[git](https://git-scm.com/)                            | free and open source distributed version control system.          |
|[curl](https://github.com/curl/curl)                   | command-line tool for transferring data specified with URL syntax |
|[jq](https://stedolan.github.io/jq/)                   | is like sed for JSON data - you can use it to slice and filter and map and transform structured data  |
|[dialog](http://linuxcommand.org/lc3_adv_dialog.php)   | generate the dialog boxes inside terminal                                      |

## Instalation

**via curl**
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/szunaj13pl/shell-gitlab/develop/install.sh)"
```
**via wget**
```
sh -c "$(wget https://raw.githubusercontent.com/szunaj13pl/shell-gitlab/develop/install.sh -O -)"
```
**or step by step**

```
    # Create tempormaly folder for clean instalation
    
        temp_gitlab_folder=$(mktemp -d /tmp/gitlab.XXXXXX)
    
    
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
    
        rm  -rf "$temp_gitlab_folder"

    # DONE! Now you can use 'gitlab' like command

```
