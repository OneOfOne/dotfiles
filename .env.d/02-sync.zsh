
alias rcp="rsync -avhP"
alias rmv="rcp --remove-source-files"

alias rc="rclone --fast-list -x"

function rc-photos {
	local args=${@:1:$(($# - 1))}
	local dst="${@: -1}"
	
	rc copy $args "gdrive-ooo:Google Photos/$dst/"
}
