include globals.local
include disable-xdg.inc
include whitelist-run-common.inc
include whitelist-runuser-common.inc

whitelist /usr/share/nvim
whitelist ${HOME}/.git*
whitelist ${HOME}/.dotfiles
whitelist ${HOME}/.cache/nvim
whitelist ${HOME}/.config/nvim
whitelist ${HOME}/.config/lazygit
whitelist ${HOME}/.local/share/nvim
whitelist ${HOME}/.local/state/nvim

read-write ${HOME}/.dotfiles/.config/nvim
read-write ${HOME}/.config/lazygit
read-write ${HOME}/.cache/nvim
read-write ${HOME}/.config/nvim
read-write ${HOME}/.local/share/nvim
read-write ${HOME}/.local/state/nvim

# custom addons
whitelist ${HOME}/code/nvim/spm.nvim


# copilot
whitelist ${HOME}/.config/github-copilot
read-write ${HOME}/.config/github-copilot

# go
whitelist ${HOME}/code/go/
whitelist ${HOME}/.cache/go-build
read-write ${HOME}/.cache/go-build

ipc-namespace
nogroups
nonewprivs
noroot
protocol unix,inet,inet6
seccomp
seccomp.block-secondary
tracelog

private-dev

restrict-namespaces
