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
alias df="df -Th --total"
alias duh="du -ach | sort -h"
alias duh1="du -ach --max-depth=1 | sort -h"
alias myip="curl -s -S https://icanhazip.com"

alias grep="grep --color"
alias egrep="egrep --color"
alias fgrep="fgrep --color"

alias sudo="sudo "

alias ports="sudo ss -nl -tup"
alias pss="ps -Ao pid:5,state:1,user,cmd | grep -v grep | egrep"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias psmem='ps -e -orss=,args= | sort -b -k1,1n'
alias psmem10='ps -e -orss=,args= | sort -b -k1,1n| head -10'
# get top process eating cpu if not work try excute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr | head -10'

path=($HOME/.dotfiles/bin $path)
path=($HOME/bin $path)

function mkcd {
	command mkdir -p $1 && pushd $1 >/dev/null
}

function mkgit {
	mkcd $1 && git init
}

if [ -x /usr/bin/nvim ]; then
	export VTE_VERSION=100
	export EDITOR="/usr/bin/nvim"
	alias vim="/usr/bin/nvim"
fi

function _err {
	echo $@ >/dev/stderr
}

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'
