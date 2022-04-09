export EDITOR='vim'

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
alias cpy="xclip -selection clipboard"
alias poff="poweroff"
alias y="yes"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
