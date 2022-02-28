# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ENV_FILES="$HOME/.dotfiles/.env.d"
ZSH="$ENV_FILES/oh-my-zsh"
ZSH_CUSTOM="$ZSH.custom/"
#ZSH_CACHE_DIR="$HOME/.cache/.zsh"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
CLOUDSDK_HOME="$HOME/sdk/google-cloud/"

plugins=(
	common-aliases # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
	copypath
	copyfile
	command-not-found
	direnv
	docker-compose
	dotenv
	isodate
	zsh-syntax-highlighting
	ripgrep
	sudo # press esc twice
)

[[ -d "${CLOUDSDK_HOME}" ]] && plugins+=(gcloud kubectl)

case "$(uname -s)" in
	Linux)
		plugins+=(systemd);;
	Darwin)
		plugins+=(macos brew);;
esac

ZSH_THEME="powerlevel10k/powerlevel10k"
P10K_PATH="$ZSH_CUSTOM/p10k.zsh"

[[ -f $P10K_PATH ]] && source $P10K_PATH

source $ZSH/oh-my-zsh.sh

for file in $ENV_FILES/*.zsh; do
	source "$file"
done

ttyctl -f # fix annoying apps that don't exit right

DOTS="$HOME/.dotfiles"
alias .git="git --git-dir=$DOTS/.git --work-tree=$DOTS"
alias .gitup=".git pull --recurse-submodules && .git submodule update --init --force && .reload"
alias .reload="source ~/.zshrc"

# ensure path includes only unique pathes
typeset -aU path
autoload -U compinit && compinit
