
alias rcp="rsync -axHAWXS --numeric-ids --info=progress2"
alias rmv="rcp --remove-source-files"

alias rc="rclone --fast-list -x"

function rc-photos {
	local args=${@:1:$(($# - 1))}
	local dst="${@: -1}"

	rc copy $args "gdrive-ooo:Google Photos/$dst/"
}

which sshfs &>/dev/null && alias sshfs="sshfs -C -oreconnect,dcache_timeout=120,kernel_cache,auto_cache,attr_timeout=120,entry_timeout=60,auto_unmount "
