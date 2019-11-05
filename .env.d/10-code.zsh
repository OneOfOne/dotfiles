export GOCACHE="/tmp/.gocache"
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"
export GOFLAGS="-gcflags=-c=16"
export GO111MODULE="${GO111MODULE:-off}" # off by default for now

path=($HOME/.config/yarn/global/node_modules/.bin $path)
path=($GOBIN $path)

for gv in $(command ls /usr/src/ | egrep '^go'); do
	name="${gv/./}"
	[ "$name" = "go" ] && name="gotip"
	alias $name="/usr/src/$gv/bin/go"
done

unset gv name

alias code-gomod="env GO111MODULE=on code"

alias gow64="env GOOS=windows GOARCH=amd64 CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ go"
alias gow32="env GOOS=windows GOARCH=386 CGO_ENABLED=1 CC=i686-w64-mingw32-gcc CXX=i686-w64-mingw32-g++ go"

alias killgo="killall -9 gocode go-langserver bingo gopls &>/dev/null"

hash -d gh="$GOPATH/src/github.com/"
hash -d mygh="$GOPATH/src/github.com/OneOfOne/"
hash -d ooo="$GOPATH/src/oneofone.net/"


function setgo {
	local v="$1"
	if [ -z "$v" ]; then
		go version
		return
	fi

	[ "$v" = "tip" -o "$v" = "master" ] && v=""

	local p="/usr/src/go$v/bin"

	if [ ! -d "$p" ]; then
		_err "$p doesn't exist."
		return 1
	fi

	ln -svf $p/{go,gofmt} $HOME/bin || return 1

	go clean -r -cache -testcache &>/dev/null
	go version
}

alias setgomod="export GO111MODULE=on; killgo"
alias unsetgomod="export GO111MODULE=off; killgo"

function rebuildgo {
	local v="$1"
	pushd "/usr/src/go$v/src" >/dev/null
	trap "popd >/dev/null" EXIT
	rm -rf ../pkg ../bin $GOPATH/pkg &>/dev/null

	git reset --hard || return 1
	git clean -fdx || return 1
	git pull -v || return 1

	env GOROOT_BOOTSTRAP=/usr/lib/go CC=gcc GOGC=off bash make.bash || return 1

	[ "$v" != "" ] && ../bin/go clean -r -cache -testcache &>/dev/null
	echo -------------------------------
	echo updated $(../bin/go version)
	echo -------------------------------
}

function rebuildgotools {
	killgo

	echo -------------------------------
	echo using $(go version)
	echo -------------------------------

	env GO111MODULE=off GOGC=off go get -u -v $@ \
		golang.org/x/tools/cmd/... \
		honnef.co/go/tools/... \
		github.com/davidrjenni/reftools/cmd/fillstruct

}
