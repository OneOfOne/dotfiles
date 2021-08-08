# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
	docker-compose
	systemd
	git-prompt
	zsh-syntax-highlighting
	resty
)

ZSH_THEME="powerlevel10k/powerlevel10k"
P10K_PATH="$ZSH_CUSTOM/p10k.zsh"
[[ -f $P10K_PATH ]] && source $P10K_PATH

source $ZSH/oh-my-zsh.sh

for file in $ENV_FILES/*.zsh; do
	source "$file"
done

# ensure path includes only unique pathes
typeset -aU path
autoload -U compinit && compinit

ttyctl -f # fix annoying apps that don't exit right

alias .git="git -C $HOME/.dotfiles/"
alias .gitup=".git pull --recurse-submodules"
alias .reload="source ~/.zshrc"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/oneofone/google-cloud-sdk/path.zsh.inc' ]; then . '/home/oneofone/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/oneofone/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/oneofone/google-cloud-sdk/completion.zsh.inc'; fi
