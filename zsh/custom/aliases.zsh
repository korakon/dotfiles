# Color ls
alias ls='ls --color=auto'

# Color grep
alias grep='grep -n --color=auto'

# Color less
export less="-R"

# Display available ram in mb
alias free="free -m -h"

# I hate to type clear
alias c="clear"

# G for git
alias g="git"

# git status
alias gs="git status"

# ga - git add
alias ga="git add"

# gc - git commit
alias gc="git commit"

# gl - git log
alias gl="git log"

alias gd="git diff"

alias gt="git difftool"

# ls vertical file list, show dirs first, files second, links third
alias lsl="ls -1 --group-directories-first"

# v for vim
alias v="vim"

# e for emacs
#alias e="emacsclient -c -a '' &"

# j for jobs
alias j=jobs

# k is kill
alias k=kill

alias m=make

alias t="timer"
alias t10m="timer 10m"

# post json using curl
alias cuson='curl -H "Accept: application/json" -H "Content-Type: application/json"'
alias ffprobe=ffprobe -hide_banner
