#!/usr/bin/env zsh
# Updates ~/.dotfiles, links its configs into $HOME and installs bun + global packages.
# Safe to re-run: existing correct links are left alone, foreign files are never overwritten.
[ -n "$ZSH_VERSION" ] || {
	echo "setup.sh: must be run with zsh" >&2
	exit 1
}
setopt err_exit no_unset pipe_fail

readonly SELF=${0:t}
readonly DOTS=$HOME/.dotfiles
readonly HOME_FILES=(.zshrc .gitconfig .wezterm.lua .tmux.conf)
# .config entries that are never linked (gitignored, machine-local VS Code profile/cache)
readonly CONFIG_EXCLUDES=(Code)
# Runs inside each submodule (sh): track the remote default branch, fast-forward only, never fail the loop.
readonly SUBMODULE_TRACK='b=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null || git remote show origin 2>/dev/null | sed -n "s/.*HEAD branch: //p"); b=${b#origin/}
if [ -z "$b" ]; then echo "warning: $displaypath: cannot determine default branch" >&2
elif ! { git checkout -q "$b" && git pull -q --ff-only; }; then echo "warning: $displaypath: failed to update $b" >&2; fi'

integer dry_run=0 do_update=1 do_bun=1
typeset -a warnings

usage() {
	print -r -- "Usage: $SELF [options]

Updates $DOTS, links its configs into \$HOME and installs bun + global packages.

  -n, --dry-run    print what would be done without changing anything
      --no-update  skip git pull and submodule updates
      --no-bun     skip installing/upgrading bun and 'bun install'
  -h, --help       show this help"
}

info() { print -r -- "==> $*"; }
warn() {
	print -ru2 -- "warning: $*"
	warnings+=("$*")
}
die() {
	print -ru2 -- "error: $*"
	exit 1
}
run() {
	if ((dry_run)); then
		print -r -- "[dry-run] ${(j: :)${(q-)@}}"
	else
		"$@"
	fi
}
need() {
	local c
	local -a missing
	for c in "$@"; do
		(($+commands[$c])) || missing+=("$c")
	done
	((! $#missing)) || die "missing required command(s): ${missing[*]}"
}

# link SRC DEST: create/fix the symlink DEST -> SRC; never touch a DEST that isn't a symlink.
link() {
	local src=$1 dest=$2 cur
	if [[ ! -e $src ]]; then
		warn "source $src does not exist; skipped"
		return 0
	fi
	if [[ -L $dest ]]; then
		cur=$(readlink "$dest")
		if [[ $cur == "$src" ]]; then
			info "ok      $dest"
			return 0
		fi
		info "relink  $dest (was -> $cur)"
	elif [[ -e $dest ]]; then
		warn "$dest exists and is not a symlink; skipped (move it away and re-run)"
		return 0
	else
		info "link    $dest -> $src"
	fi
	run ln -sfn "$src" "$dest"
}

update_repo() {
	info "updating $DOTS"
	run git -C "$DOTS" pull --ff-only --recurse-submodules ||
		warn "git pull failed (local changes or diverged history?); continuing with the current checkout"
	run git -C "$DOTS" submodule --quiet sync --recursive ||
		warn "git submodule sync failed"
	run git -C "$DOTS" submodule update --init --recursive --force ||
		warn "git submodule update failed"
	run git -C "$DOTS" submodule --quiet foreach --recursive "$SUBMODULE_TRACK" ||
		warn "updating submodules to their default branch failed"
}

link_all() {
	local f p
	run mkdir -p "$HOME/.config" "$HOME/bin"
	for f in $HOME_FILES; do
		link "$DOTS/$f" "$HOME/$f"
	done
	for p in "$DOTS"/.config/*(DN); do
		if ((${CONFIG_EXCLUDES[(Ie)${p:t}]})); then
			continue
		fi
		link "$p" "$HOME/.config/${p:t}"
	done
}

setup_bun() {
	local installer
	if [[ -x $BUN_INSTALL/bin/bun ]]; then
		info "upgrading bun"
		run bun upgrade || warn "bun upgrade failed"
	else
		# $BUN_INSTALL/bin is already on PATH, so the installer exits before appending to ~/.zshrc.
		info "installing bun into $BUN_INSTALL"
		if ((dry_run)); then
			print -r -- "[dry-run] curl -fsSL https://bun.sh/install | bash"
		else
			installer=$(mktemp "${TMPDIR:-/tmp}/bun-install.XXXXXX")
			if curl -fsSL -o "$installer" https://bun.sh/install && bash "$installer"; then
				rm -f "$installer"
			else
				rm -f "$installer"
				warn "bun installation failed; skipping package install"
				return 0
			fi
		fi
	fi
	info "installing packages from $DOTS/package.json"
	(cd "$DOTS" && run bun install) || warn "bun install failed"
}

while (($#)); do
	case $1 in
	-n | --dry-run) dry_run=1 ;;
	--no-update) do_update=0 ;;
	--no-bun) do_bun=0 ;;
	-h | --help)
		usage
		exit 0
		;;
	*)
		print -ru2 -- "$SELF: unknown option: $1"
		usage >&2
		exit 2
		;;
	esac
	shift
done

need git
git -C "$DOTS" rev-parse --is-inside-work-tree &>/dev/null ||
	die "$DOTS is not a git checkout; clone it first: git clone --recurse-submodules https://github.com/OneOfOne/dotfiles $DOTS"

export BUN_INSTALL=${BUN_INSTALL:-$HOME/.bun}
export PATH=$BUN_INSTALL/bin:$PATH
if ((do_bun)) && [[ ! -x $BUN_INSTALL/bin/bun ]]; then
	need curl unzip
fi

if ((do_update)); then
	update_repo
fi
link_all
if ((do_bun)); then
	setup_bun
fi

if (($#warnings)); then
	print -ru2 -- ""
	print -ru2 -- "finished with $#warnings warning(s):"
	print -ru2 -l -- "  - "${^warnings}
else
	info "done"
fi

if ((! dry_run)) && [[ -t 0 && -t 1 ]]; then
	info "starting a fresh zsh"
	exec zsh
fi
