export EDITOR='vim'

export ZSH="/home/god/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

set -o vi

prompt1="%B%F{magenta}%d"$'\n'
prompt2="%? %B%F{yellow}%W%f%b %B%F{cyan}%t%f%b"$'\n'
prompt3="%f%b%B%F{red}[%f%b%B%F{yellow}%n%f%b%B%F{green}@%f%b%B%F{blue}%M%f%b%B%F{red}]%f%b%B%B%F{cyan}$%f%b%b "

PROMPT=$prompt1$prompt2$prompt3

alias q="exit"
alias c="clear"
alias v="vim"
alias l="ls -lah"
alias cl="clear;ls"
alias pf="pfetch"
alias poweroff="doas poweroff"
alias cpy="xclip -selection clipboard"
alias poff="poweroff"
alias lol="lolcat"
alias y="yes"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
