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

# Export HTTP(S) proxy
export http_proxy="http://127.0.0.1:7890"
export HTTP_PROXY="$http_proxy"
export https_proxy="$http_proxy"
export HTTPS_PROXY="$http_proxy"
export no_proxy="localhost,127.0.0.1, 0.0.0.0, 192.168.0.1/24,192.168.1.1/24"
export NO_PROXY="$no_proxy"

function unset_proxy {
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
}

## General commands
cs() { cd "$@" && ls }

## Git commands
alias gs='git status'
alias gc='git add --all; git commit -m'
alias gp='git push'
alias gl='git pull'
alias gll='git log'
alias gdc='git diff > diff.diff; code diff.diff'

## SSH Servers
alias lf='ssh lf@192.168.1.82'
alias bk='ssh backups'
alias cpi='ssh cpi'

# HTTPie commands
alias post='http POST'
alias put='http PUT'
alias get='http GET'

# Function for viewing LHC logs
function lhclog {
    lhc_log_viewer.sh $@
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

alias kd='kube-deploy'

# Make aliases
alias mf='make clean ; make flash'

# Spotify shortcut
alias sp="spotify"

# Alias for pytest, flake8, and flask
alias pytest="python -m pytest"
alias pt=pytest
alias flake="python -m flake8"
alias flask="python -m flask"
alias fr="flask run"
alias fs="flask shell"

# Force creation of Python virtual environment in project dir
# This is needed as Pycharm recreates the virtual env and does not have this set when creating the environment
export PIPENV_VENV_IN_PROJECT=true

# Sleep enable disable shortcuts
alias sleepon="pmset -a disablesleep 1"
alias sleepoff="pmset -a disablesleep 1"

# CANbus monitor
alias cmoni="can_moni"

# Pycharm launcher and diff shortcuts
alias pc="pycharm ."
alias pcd="pycharm diff"
