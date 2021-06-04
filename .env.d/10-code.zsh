# export GOCACHE="/tmp/.gocache"
export GOPATH="$HOME/code/go"
export GO2PATH="/usr/src/go2/src/cmd/go2go/testdata/go2path:$GOPATH"
export GOBIN="$GOPATH/bin"
export GOSUMDB="off"
export GOPROXY="direct"
export GO111MODULE=auto

path=($HOME/.config/yarn/global/node_modules/.bin $path)
path=($GOBIN $HOME/.cargo/bin/ $path)

for gv in $(command ls /usr/src/ | egrep '^go'); do
	name="${gv/./}"
	[ "$name" = "go" ] && name="gotip"
	alias $name="/usr/src/$gv/bin/go"
done

unset gv name

alias gow64="env GOOS=windows GOARCH=amd64 CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ go"
alias gow32="env GOOS=windows GOARCH=386 CGO_ENABLED=1 CC=i686-w64-mingw32-gcc CXX=i686-w64-mingw32-g++ go"

alias killgo="killall -9 gocode go-langserver bingo gopls &>/dev/null"

hash -d gh="$GOPATH/src/github.com/"
hash -d mygh="$GOPATH/src/github.com/OneOfOne/"
hash -d ooo="$GOPATH/src/go.oneofone.dev/"

alias go2go="/usr/src/go2/bin/go tool go2go"

function setgo {
	local v="$1"
	if [ -z "$v" ]; then
		go version
		return
	fi

	[ "$v" = "tip" -o "$v" = "master" ] && v=""
	local p="/usr/src/go$v/bin"

	if [ "$v" = "os" -o "$v" = "main" ]; then
		p="/usr/bin"
	fi

	if [ ! -d "$p" ]; then
		_err "$p doesn't exist."
		return 1
	fi


	ln -svf $p/{go,gofmt} $HOME/bin || return 1
	# go clean -r -cache -testcache &>/dev/null
	go version
}

function addgotree {
	local v="$1"
	pushd /usr/src/go >/dev/null && trap "popd >/dev/null" EXIT
	git pull --all || return 1
	git worktree remove ../go$v
	git branch -d go$v &>/dev/null
	git worktree add ../go$v --track -b go$v --checkout origin/release-branch.go$v || return 1
	rebuildgo $v
}

function removegotree {
	local v="$1"
	pushd /usr/src/go >/dev/null && trap "popd >/dev/null" EXIT
	git worktree remove ../go$v
	git branch -d go$v &>/dev/null
	rm -v ~/bin/go$v
}

function rebuildgo {
	local v="$1"
	pushd "/usr/src/go$v/src" >/dev/null && trap "popd >/dev/null" EXIT
	rm -rf ../pkg ../bin $GOPATH/pkg &>/dev/null

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

	cd ~gh/go-delve/delve/
	git reset --hard
	git pull || return 1
	go get -u ./...
	go mod tidy
	go mod vendor
	make install && rm -rf vendor

	cd ~gh/../golang.org/x/tools/gopls
	git reset --hard && git pull || return 1
	env GO111MODULE=on GOGC=off go install -v

	cd ~/code/vscode/vscode-go
	git reset --hard
	git pull || return 1
	npm install || return 1
	vsce package -o /tmp/gocode.vsix || return 1
	code --install-extension /tmp/gocode.vsix --force || return 1

	killgo
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
	rebuildgo || return 1
	rebuildgotools || return 1
}

function go2 {

}
