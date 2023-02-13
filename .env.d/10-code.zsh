# export GOCACHE="/tmp/.gocache"
export SDKBASE="$HOME/sdk"
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"
export GOSUMDB="off"
export GOPROXY="direct"
export GO111MODULE=auto
export GOTIPROOT="$HOME/sdk/go"
# export CLOUDSDK_PYTHON=python2
export GOAMD64=v3


# if [ -x /bin/zig ]; then
# 	export CC="zig cc"
# 	export CXX="zig cxx"
# fi

path=($HOME/.config/yarn/global/node_modules/.bin $path)
path=($GOBIN $HOME/.cargo/bin/ $path)

for gv in $(command ls "$SDKBASE/" 2>&1 | grep -E '^go'); do
	name="${gv/./}"
	[ "$name" = "go" ] && name="gotip"
	alias $name="$SDKBASE/$gv/bin/go"
done

unset gv name

alias gow64="env GOOS=windows GOARCH=amd64 CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ go"
alias gow32="env GOOS=windows GOARCH=386 CGO_ENABLED=1 CC=i686-w64-mingw32-gcc CXX=i686-w64-mingw32-g++ go"

hash -d gh="$GOPATH/src/github.com/"
hash -d mygh="$GOPATH/src/github.com/OneOfOne/"
hash -d ooo="$GOPATH/src/go.oneofone.dev/"

function setgo {
	local v="$1"
	if [ -z "$v" ]; then
		go version
		return
	fi

	[ "$v" = "tip" -o "$v" = "master" ] && v=""
	local p="${GOTIPROOT}$v/bin"

	if [ "$v" = "os" -o "$v" = "main" ]; then
		p="/usr/bin"
	fi

	if [ ! -d "$p" ]; then
		_err "$p doesn't exist."
		return 1
	fi


	ln -svf $p/{go,gofmt} $HOME/bin || return 1
	go version
}

function addgotree {
	set -o localoptions -o localtraps
	local v="$1"
	pushd ${GOTIPROOT} >/dev/null && trap "popd >/dev/null" EXIT
	git pull --all || return 1
	git worktree remove ../go$v
	git branch -d go$v &>/dev/null
	git worktree add ../go$v --track -b go$v --checkout origin/release-branch.go$v || return 1
	rebuildgo $v
}

function removegotree {
	set -o localoptions -o localtraps
	local v="$1"
	pushd ${GOTIPROOT} >/dev/null && trap "popd >/dev/null" EXIT
	git worktree remove ../go$v
	git branch -d go$v &>/dev/null
	rm -v ~/bin/go$v
}

function rebuildgo {
	set -o localoptions -o localtraps
	local v="$1"
	pushd "${GOTIPROOT}$v/src" >/dev/null && trap "popd >/dev/null" EXIT
	/bin/rm -rf ../pkg ../bin &>/dev/null

	git reset --hard || return 1
	git clean -fdx || return 1
	git pull -v || return 1

	env GOROOT_BOOTSTRAP=/usr/lib/go CC=gcc GOGC=off bash make.bash || return 1

	if [ "$v" != "" ]; then
		ln -fs $PWD/../bin/go ~/bin/go$v
	fi

	echo -------------------------------
	echo updated $(../bin/go version)
	echo -------------------------------
}

function rebuildgotools {
	set -o localoptions -o localtraps
	echo -------------------------------
	echo using $(go version)
	echo -------------------------------

	# env GO111MODULE=off GOGC=off go get -u -v $@ \
	# 	github.com/fatih/gomodifytags \
	# 	github.com/josharian/impl \
	# 	github.com/haya14busa/goplay/cmd/goplay \
	# 	github.com/godoctor/godoctor \
	# 	github.com/rogpeppe/godef \
	# 	github.com/sqs/goreturns \
	# 	honnef.co/go/tools/... 2>&1 | egrep -v 'meta tag'

	pushd ~gh/go-delve/delve/ && trap "popd >/dev/null" EXIT
	git reset --hard
	git pull || return 1
	go mod vendor || return 1
	# go mod tidy || return 1
	make install || return 1
	popd &> /dev/null

	pushd ~gh/../golang.org/x/tools/gopls && trap "popd >/dev/null" EXIT
	git reset --hard && git pull || return 1
	env GO111MODULE=on GOGC=off go install -v || return 1

	pushd ~/code/vscode/vscode-go && trap "popd >/dev/null" EXIT
	git reset --hard
	git pull || return 1
	npm install || return 1
	vsce package -o /tmp/gocode.vsix || return 1
	code --install-extension /tmp/gocode.vsix --force || return 1

	pkill -9 gopls &>/dev/null
}

function gotest {
	local n="${1:-.}"
	[ "$1" != "" ] && shift
	go test -count=1 -v -run="$n" $@
}

function gobench {
	local n="${1:-.}";
	[ "$1" != "" ] && shift
	go test -count=1 -v -run='^$' -benchmem -bench="$n" $@
}

function gobump {
	rebuildgo $1 || return 1
	setgo $1 || return 1
	rebuildgotools || return 1
}

function gots {
	node -p "new Date($1 * 1000)"
}

function gcp-enable-log {
	gsutil logging set on -b gs://$1 -o AccessLog gs://$1
}
