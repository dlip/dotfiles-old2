# Command Enhancements

# Utility
alias reload='source ~/.bashrc'
alias v="vim"

# Common -- Some are from Damian Conway
alias a='ls -A' # -A all except literal . ..
alias la="ls -A -l -G"
alias c='clear'
alias cdd='cd -'  # goto last dir cd'ed from
alias cl='clear; l'
function cdc() { 
    cd $1; ls 
}
alias cls='clear; ls'
alias h='history'
alias l.='ls -d .[^.]*'
alias l='ls -lhGt'  # -l long listing, most recent first
                    # -G color
alias lh="ls -lh"
alias ll='ls -lhG'  # -l long listing, human readable, no group info
alias lt='ls -lt' # sort with recently modified first
alias md='mkdir -p'
alias ..='cd ..'   # up one dir

function take() { 
    mkdir -p "$1"
    cd "$1" 
}

# Processes
alias tu='top -o cpu' # cpu
alias tm='top -o vsize' # memory


# Ruby
alias r="rake"

# Rails
alias rs='bundle exec rails s'
alias rl='tail -f log/*.log'
