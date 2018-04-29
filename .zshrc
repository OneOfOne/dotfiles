export ZSH="$HOME/.env.d/oh-my-zsh"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$ZSH.custom/"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	common-aliases
	command-not-found
	systemd
	shrink-path
	git
	gitfast
	zsh-syntax-highlighting
)


source $ZSH/oh-my-zsh.sh

for file in ~/.env.d/*.zsh; do
    source "$file"
done

# ensure path includes only unique pathes
typeset -aU path
autoload -U compinit && compinit
