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
	copybuffer
	copypath
	copyfile
	dotenv
	isodate
	zsh-syntax-highlighting
	zsh-interactive-cd
	git
	aliases
	sudo
	safe-paste
)

[[ -d "${CLOUDSDK_HOME}" ]] && plugins+=(gcloud kubectl)

case "$(uname -s)" in
	Linux)
		plugins+=(systemd);;
	Darwin)
		plugins+=(macos brew);
		export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
esac

ZSH_THEME="powerlevel10k/powerlevel10k"
P10K_PATH="$ZSH_CUSTOM/p10k.zsh"

[[ -f $P10K_PATH ]] && source $P10K_PATH

source $ZSH/oh-my-zsh.sh

# CTRL-R will pull up zaw-history (backwards zsh history search)
bindkey '^r' zaw-history

for file in $ENV_FILES/*.zsh; do
	source "$file"
done

ttyctl -f # fix annoying apps that don't exit right

DOTS="$HOME/.dotfiles"

function .gitup {
	cd $DOTS
	git pull --recurse-submodules
	git submodule update --init --force
	git submodule foreach --recursive git main
	bun update
	cd -
}

# ensure path includes only unique paths
typeset -aU path
autoload -U compinit && compinit

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

