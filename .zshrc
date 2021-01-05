export ZSH="/home/god/.oh-my-zsh"
export EDITOR='vim'
# export PATH="$PATH: /home/god/development/flutter/bin" # for flutter
plugins=(git)

source $ZSH/oh-my-zsh.sh

PROMPT="%B%F{green}%m%f%b:%B%F{red}[%f%b%B%F{blue}%n%f%b%B%F{red}]%f%b:%B%F{magenta}%~%f%b%B%F{yellow}$ %f%b"
alias q="exit"
alias c="clear"
alias v="vim"
alias l="ls -lah"
alias cl="clear;ls"
alias pf="pfetch"
alias poweroff="doas poweroff"
alias mutt="neomutt"
