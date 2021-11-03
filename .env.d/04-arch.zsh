alias y="yay"
alias yr="y -Rscd"
alias yi="y -S"
alias ys="y -Ss"

function update-tkg() {
	pushd ~/pkgbuilds/tkg
	git pull &>/dev/null
	git submodule foreach git checkout master 2>&1 | egrep -v '^(POST|Entering|Already)|up to date'
	git submodule foreach git pull -v 2>&1 | egrep -v '^(POST|Entering|Already)|up to date'
}
