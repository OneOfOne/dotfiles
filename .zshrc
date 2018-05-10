export ENV_FILES="$HOME/.dotfiles/.env.d"
export ZSH="$ENV_FILES/oh-my-zsh"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
#DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$ZSH.custom/"

plugins=(
	common-aliases
	systemd
	shrink-path
	git
	gitfast
	zsh-syntax-highlighting
	resty
)


source $ZSH/oh-my-zsh.sh

for file in $ENV_FILES/*.zsh; do
	source "$file"
done

# ensure path includes only unique pathes
typeset -aU path
autoload -U compinit && compinit

ttyctl -f # fix annoying apps that don't exit right

alias .git="git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME/.dotfiles"
alias .gitup=".git pull"
alias _reload="source ~/.zshrc"
