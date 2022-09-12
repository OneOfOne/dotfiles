alias y="yay"
alias yr="y -Rscd"
alias yi="y -S"
alias ys="y -Ss"

function update-tkg() {
	pushd ~/pkgbuilds/tkg
	git pull &>/dev/null
	git submodule foreach --recursive git main 2>&1 | grep -v -E '^(POST|Entering|Already)|up to date'
}
