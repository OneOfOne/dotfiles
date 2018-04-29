setopt globdots
setopt ignoreeof
setopt autocontinue
setopt extendedglob
setopt rmstarsilent

setopt histreduceblanks
setopt histignorespace
setopt histignorealldups

zstyle ':completion:*' rehash true

alias which='type -a'
alias ..='cd ..'
alias ...='cd ../..'

alias y="env PATH=/usr/bin yaourt"
alias yup="y -Syu --aur"
alias yr="y -Rscd"
alias yi="y -S"
alias ys="y -Ss"

alias ls="ls -hF --group-directories-first --color"
alias ll="ls -l --time-style='+%Y-%m-%d %H:%M'"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp --reflink=auto --sparse=always -ia"

alias mkdir="mkdir -pv"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias df="df -Tha --total"
alias duh="du -ach | sort -h"
alias myip="curl http://ipecho.net/plain; echo"

alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

alias sudo='sudo '
alias ports='netstat -tunp'

function mcd {
	command mkdir -p $1 && cd $1
}

function mkgit {
	mcd $1 && git init
}

alias .git="git --git-dir=$HOME/code/dotfiles --work-tree=$HOME"
alias _reload="source ~/.zshrc"
