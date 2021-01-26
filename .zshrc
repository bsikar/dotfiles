export ZSH="/home/god/.oh-my-zsh"
export EDITOR='vim'
set -o vi

plugins=(git)
source $ZSH/oh-my-zsh.sh

PROMPT="%B%F{magenta}%d"$'\n'"%? %B%F{yellow}%W%f%b %B%F{cyan}%t%f%b"$'\n'"%f%b%B%F{red}[%f%b%B%F{yellow}%n%f%b%B%F{green}@%f%b%B%F{blue}%M%f%b%B%F{red}]%f%b%B%B%F{cyan}$%f%b%b "
alias q="exit"
alias c="clear"
alias v="vim"
alias l="ls -lah"
alias cl="clear;ls"
alias pf="pfetch"
alias cpy="xclip -selection clipboard"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
