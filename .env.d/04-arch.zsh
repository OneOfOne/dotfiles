alias y="yay"
alias yr="y -Rscd"
alias yi="y -S"
alias ys="y -Ss"

function update-tkg() {
	pushd ~/pkgbuilds/tkg
	for d in *; do
		pushd $d
		echo pulling $d
		git pull -v
		popd
	done
	popd
}
