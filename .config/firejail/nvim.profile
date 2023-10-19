include globals.local
#include disable-xdg.inc
writable-run-user
include whitelist-run-common.inc
include whitelist-runuser-common.inc
#include whitelist-usr-share-common.inc
#include whitelist-var-common.inc
include whitelist-common.inc

whitelist /usr/share/nvim
whitelist ${HOME}/.dotfiles
whitelist ${HOME}/.cache/nvim
whitelist ${HOME}/.config/nvim
whitelist ${HOME}/.local/share/nvim
whitelist ${HOME}/.local/state/nvim

read-write ${HOME}/.dotfiles/.config/nvim
read-write ${HOME}/.cache/nvim
read-write ${HOME}/.config/nvim
read-write ${HOME}/.local/state/nvim

# gnupg & git
whitelist ${HOME}/.git*
whitelist ${HOME}/.gnupg
noblacklist ${RUNUSER}/gnupg
whitelist ${RUNUSER}/gnupg

whitelist ${HOME}/.config/lazygit
read-write ${HOME}/.config/lazygit

# custom addons
whitelist ${HOME}/code/nvim/spm.nvim

# copilot
whitelist ${HOME}/.config/github-copilot
read-write ${HOME}/.config/github-copilot

# go
whitelist ${HOME}/code/go/
whitelist ${HOME}/sdk/go/
whitelist ${HOME}/.cache/go-build
read-write ${HOME}/.cache/go-build

# rust
whitelist ${HOME}/.rustup
whitelist ${HOME}/.cargo

# zsh & term
whitelist /usr/share/zsh
whitelist /usr/share/terminfo
whitelist ${HOME}/.terminfo/
whitelist ${HOME}/.cache/gitstatus
whitelist ${HOME}/.zsh*
whitelist ${HOME}/.cache/p10k-oneofone

# other
whitelist ${HOME}/.npm
whitelist ${HOME}/.expo

whitelist ${HOME}/.config/gcloud
whitelist ${HOME}/.ssh/google*
whitelist ${HOME}/.docker
whitelist /run/docker*

whitelist ${HOME}/pkgbuilds

# neoovide

whitelist ${HOME}/.local/share/icons
whitelist ${HOME}/.local/share/fonts
whitelist ${HOME}/.cache/mesa*

ipc-namespace
caps.drop all
nogroups
nonewprivs
noroot
protocol unix,inet,inet6
seccomp
seccomp.block-secondary
tracelog

private-dev
private-tmp

restrict-namespaces
