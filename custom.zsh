# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# iTerm integration
if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

# Language settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Force creation of Python virtual environment in project dir
# This is needed as Pycharm recreates the virtual env and does not have this set when creating the environment
export PIPENV_VENV_IN_PROJECT=true

## Git aliases
alias gs='git status'
alias gc='git add --all; git commit -m'
alias gp='git push'
alias gl='git pull'
alias gll='git log'
alias gdc='git diff > diff.diff; code diff.diff'

# HTTPie aliases
alias post='http POST'
alias put='http PUT'
alias get='http GET'

# Export HTTP(S) proxy
function proxy {
   export http_proxy="http://127.0.0.1:7890"
   export HTTP_PROXY="$http_proxy"
   export https_proxy="$http_proxy"
   export HTTPS_PROXY="$http_proxy"
   export no_proxy="10.0.0.0/8,192.168.0.0/16,127.0.0.0/8,172.16.0.0/16,localhost,0.0.0.0,.docker.internal,hz-onsite.life-foundry.com"
   export NO_PROXY="$no_proxy"
}

function noproxy {
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    unset no_proxy
    unset NO_PROXY
}

function ip {
    ifconfig | grep 192 -B4
}

# CD into a directory then run ls
cs() {
    cd "$@" && ll
}

# Git cleanup function
function clean() {
    git fetch --prune -v
    git branch --merged | egrep -v "(^\*|main)" | xargs git branch -d
    git branch -r --merged | egrep -v "(^\*|main)" | xargs -n 1 git push --delete origin
}

function netl {
    if (( $# == 0 ))
    then
        netstat -an | (read a; read a; echo "$a"; grep 127.0.0.1)
    else
        netstat -an | (read a; read a; echo "$a"; grep $1)
    fi
}

# Function to start and stop local mongodb service
function mongo {
    if [[ "$1" = "start" ]]
    then
        brew services start mongodb-community@5.0
    elif [[ "$1" = "stop" ]]
    then
        brew services stop mongodb-community@5.0
    elif [[ "$1" = "restart" ]]
    then
        brew services restart mongodb-community@5.0
    else
        mongosh $1  # Pass through to mongosh
    fi
}


# Function to build docker image in the currect directory
function dbuild {  # dbuild: docker build
    SERVICE_NAME=$(yq '.standard_config.name' config/service_config.yaml)
    docker build . --build-arg SERVICE_PORT_ARG=$LOCAL_SERVICE_PORT --tag $SERVICE_NAME
}
alias db='dbuild'

# Function to run a docker image
function drun {  # drun: docker run
    SERVICE_NAME=$(yq '.standard_config.name' config/service_config.yaml)
    docker run --rm -p $LOCAL_SERVICE_PORT:$LOCAL_SERVICE_PORT --name $SERVICE_NAME $SERVICE_NAME
}
alias dr='drun'

# Sleep enable disable shortcuts
alias sleepon="pmset -a disablesleep 1"
alias sleepoff="pmset -a disablesleep 1"

# Spotify shortcut
alias sp="spotify"

# Make clean then build/flash alias
alias mf='make clean ; make flash'

# Alias for pytest, flake8, and flask and kube-deploy tools
alias pytest="python -m pytest"
alias pt=pytest
alias flake="python -m flake8"
alias flask="python -m flask"
alias fr="flask run"
alias fs="flask shell"
alias kd='kube-deploy'

# Pycharm / CLion launcher and diff shortcuts

function launch_editor() {
    if [ "$2" != "" ]
    then
        $1 $2
    else
        $1 .
    fi
}

function pc() {
    launch_editor pycharm "${1}"
}
alias pcd="pycharm diff"

function cl() {
    launch_editor clion "${1}"
}
alias cld="clion diff"

function fl() {
    launch_editor fleet "${1}"
}
alias fld="fleet diff"
