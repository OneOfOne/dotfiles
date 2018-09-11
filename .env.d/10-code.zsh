export GOCACHE="/tmp/.gocache"
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"

path=($HOME/.config/yarn/global/node_modules/.bin $path)
path=($GOBIN $path)

for gv in $(command ls /usr/src/ | egrep '^go'); do
	name="${gv/./}"
	[ "$name" = "go" ] && name="gotip"
	alias $name="env GO111MODULE=off /usr/src/$gv/bin/go"
done

unset gv name

alias gow64="env GOOS="windows" GOARCH="amd64" CGO_ENABLED="1" CC="x86_64-w64-mingw32-gcc" CXX="x86_64-w64-mingw32-g++" go"
alias gow32="env GOOS="windows" GOARCH="386" CGO_ENABLED="1" CC="i686-w64-mingw32-gcc" CXX="i686-w64-mingw32-g++" go"

alias killgo="killall -9 gocode go-langserver &>/dev/null"

hash -d gh="$GOPATH/src/github.com/"
hash -d mygh="$GOPATH/src/github.com/OneOfOne/"
hash -d meteora="$GOPATH/src/github.com/missionMeteora/"
hash -d swayops="$GOPATH/src/github.com/swayops/"
hash -d pdna="$GOPATH/src/github.com/PathDNA/"

function setgo {
	local v="$1"
	if [ -z "$v" ]; then
		go version
		return
	fi

	[ "$v" = "tip" -o "$v" = "master" ] && v=""

	local p="/usr/src/go$v/bin/"

	if [ ! -d "$p" ]; then
		_err "$p doesn't exist."
		return 1
	fi

	ln -svf $p/{go,gofmt} $HOME/bin || return 1

	go clean -cache -testcache &>/dev/null
	go version
}

alias setgomod="export GO111MODULE=on"

function rebuildgo {
	local v="$1"
	pushd "/usr/src/go$v/src" >/dev/null
	trap "popd >/dev/null" EXIT
	rm -rf ../pkg ../bin $GOPATH/pkg &>/dev/null

	git reset --hard || return 1
	git clean -fdx || return 1
	git pull -v || return 1

	env GOROOT_BOOTSTRAP=/usr/src/go1.4 CC=gcc GOGC=off bash make.bash

	../bin/go clean -r -cache -testcache &>/dev/null
	echo -------------------------------
	echo updated $(../bin/go version)
	echo -------------------------------
}

function rebuildgotools {
	killall -9 gocode go-langserver &>/dev/null
	echo -------------------------------
	echo using $(go version)
	echo -------------------------------

	go clean -r -cache -testcache

	go get -u $@ \
		golang.org/x/... \
		github.com/mdempsky/gocode \
		github.com/uudashr/gopkgs/cmd/gopkgs \
		github.com/ramya-rao-a/go-outline \
		github.com/acroca/go-symbols \
		github.com/fatih/gomodifytags \
		github.com/haya14busa/goplay/cmd/goplay \
		github.com/josharian/impl \
		github.com/tylerb/gotype-live \
		github.com/rogpeppe/godef \
		github.com/zmb3/gogetdoc \
		github.com/sqs/goreturns \
		github.com/golang/lint/golint \
		github.com/cweill/gotests/... \
		github.com/alecthomas/gometalinter \
		honnef.co/go/tools/... \
		github.com/sourcegraph/go-langserver \
		github.com/derekparker/delve/cmd/dlv \
		github.com/davidrjenni/reftools/cmd/fillstruct
}
