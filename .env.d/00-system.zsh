# Switching directories for lazy people
setopt autocd
# See: http://zsh.sourceforge.net/Intro/intro_6.html
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
# Don't kill background jobs when I logout
setopt nohup
# See: http://zsh.sourceforge.net/Intro/intro_2.html
setopt extendedglob
# Do not require a leading '.' in a filename to be matched explicitly
#setopt globdots
# Try to make the completion list smaller (occupying less lines) by printing
# the matches in columns with different widths
setopt listpacked
setopt longlistjobs # Display PID when using jobs
#setopt ignoreeof
#setopt autocontinue
# setopt rmstarsilent

setopt histreduceblanks histignorespace histignorealldups

#autoload -U regexp-replace
setopt re_match_pcre

autoload zmv

zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' special-dirs false

alias ..="cd .."
alias ...="cd ../.."
alias pcd="popd"

path=($HOME/.dotfiles/bin $path)
path=($HOME/bin $path)

# macos utils are horrid
if [[ $(uname -s) == 'Darwin' ]]; then
	export HOMEBREW_NO_ENV_HINTS=1
	path=($(find /opt/homebrew/Cellar -name gnubin) /opt/homebrew/bin $path)
fi

alias ls="ls -hF --group-directories-first --color"
alias ll="ls -l --time-style='+%Y-%m-%d %H:%M'"
alias cp="cp --reflink=auto --sparse=always -ia"
alias ports="sudo ss -nl -tup"
alias pss="ps -Ao pid:5,state:1,user,cmd | grep -v grep | grep -E"
alias df="df -Th --total"
alias duh="du -ach | sort -h"

alias mkdir="mkdir -pv"
alias myip="curl -s -S https://icanhazip.com"

alias grep="grep --color"
alias egrep="grep -E --color"
alias fgrep="grep -F --color"

function mkcd {
	command mkdir -p $1 && pushd $1 >/dev/null
}

function mkgit {
	mkcd $1 && git init
}

if [ -x /bin/nvim ]; then
	export VTE_VERSION=100
	export EDITOR="/bin/nvim"
	export GIT_EDITOR="/bin/nvim"
fi

function _err {
	echo $@ >/dev/stderr
}

export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'

alias visu="sudo -E nvim"

# set term tab size
[[ $- == *i* ]] && tabs -4

env | grep -q SSH && export TERM=xterm-256color

[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

function update-nvim {
	mkcd ~/bin/ &&
		curl -O -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage &&
		chmod +x nvim.appimage &&
		./nvim.appimage --appimage-extract &&
		ln -sfv ~/bin/squashfs-root/usr/bin/nvim ~/bin/nvim
}

if ! nvim --version | grep -q v0.1; then
	# update-nvim
fi

export GPG_TTY=$(tty)
