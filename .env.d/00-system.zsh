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

#autoload -U regexp-replace qq
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

path=($path /opt/rocm/bin)

typeset -aUT LD_LIBRARY_PATH ld_library_path
ld_library_path=($ld_library_path /opt/rocm/lib)
export LD_LIBRARY_PATH

# macos utils are horrid
if [[ $(uname -s) == 'Darwin' ]]; then
	if [[ -d /opt/homebrew ]]; then
		export HOMEBREW_NO_ENV_HINTS=1
		path=($(find /opt/homebrew/Cellar -name gnubin) /opt/homebrew/bin $path)
	else
		path=($(find /usr/local -name gnubin) $path)
	fi
fi

alias ls="ls -hF --group-directories-first --color"
alias ll="ls -l --time-style='+%Y-%m-%d %H:%M'"
alias cp="cp --reflink=auto --sparse=always -ia"
alias ports="sudo ss -nl -tup"
alias pss="ps -Ao pid:5,state:1,user,cmd | grep -v grep | grep -E"
alias df="df -Th --total"
alias duh="du -ach | sort -h"

alias mkdir="mkdir -pv"
alias myip="curl -s -S https://oneofone.dev/ip"

alias grep="grep --color"
alias egrep="grep -E --color"
alias fgrep="grep -F --color"

alias hg="history | grep"

function mkcd {
	command mkdir -p $1 && pushd $1 >/dev/null
}

function mkgit {
	mkcd $1 && git init
}

function update-mirrors {
	sudo reflector --verbose --protocol https --latest 10 --age 1 -c US --sort rate -f 20 --save /etc/pacman.d/mirrorlist
	sudo env RATE_MIRRORS_COUNTRY_NEIGHBORS_PER_COUNTRY=0 RATE_MIRRORS_ENTRY_COUNTRY=US cachyos-rate-mirrors
}

if [ "$(command -v nvim)" != "" ]; then
	export VTE_VERSION=100
	export EDITOR="$(command -v nvim)"
	export GIT_EDITOR="$(command -v nvim)"
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
	set -x

	ARCH="x86_x64"
	[[ "$(uname -m)" == "aarch64" ]] && ARCH="arm64"

	mkcd ~/bin/ &&
		curl -O -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-${ARCH}.appimage &&
		chmod +x nvim-linux-${ARCH}.appimage &&
		./nvim-linux-${ARCH}.appimage --appimage-extract &&
		ln -sfv ~/bin/squashfs-root/usr/bin/nvim ~/bin/nvim &&
		rm -v nvim-linux-${ARCH}.appimage
	cd -
}

export GPG_TTY=$(tty)
