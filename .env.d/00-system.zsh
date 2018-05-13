setopt globdots
setopt ignoreeof
setopt autocontinue
setopt extendedglob
setopt rmstarsilent

setopt histreduceblanks
setopt histignorespace
setopt histignorealldups

autoload -U regexp-replace
setopt re_match_pcre

zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _complete _ignored _files

alias which="type -a"
alias ..="cd .."
alias ...="cd ../.."

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

alias grep="grep --color"
alias egrep="egrep --color"
alias fgrep="fgrep --color"

alias sudo="sudo "

path=($HOME/.dotfiles/bin $path)
path=($HOME/bin $path)

function mcd {
	command mkdir -p $1 && pushd $1 >/dev/null
}

function mkgit {
	mcd $1 && git init
}

if [ -x /usr/bin/nvim  ]; then
	export VTE_VERSION=100
	export EDITOR="/usr/bin/nvim"
	alias vim="/usr/bin/nvim"
fi

function _err {
	echo $@ >/dev/stderr
}
