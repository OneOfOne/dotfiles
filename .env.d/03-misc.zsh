export WINEDEBUG=-all
export WINEDLLOVERRIDES=winemenubuilder.exe=d

alias ports="sudo ss -nl -tup"
alias pss="ps -Ao pid:5,state:1,user,cmd | grep -v grep | egrep"

function dig-any {
	command dig $@ ANY | egrep -v '^$|^;'
}

function certbot-add-subdomain {
	set -o shwordsplit

	local host="$1"
	local subs="$2"

	if [ -z "$host" -o -z "$subs" ]; then
		_err "usage: certbot-add-subdomain domain sub,sub2[.domain],..."
		return 1
	fi

	for sub in ${subs//,/ }; do
		if ! [[ $sub =~ "\.$host$" ]]; then
			subs=${subs/$sub/$sub.$host}
		fi
	done

	local curDomains="$(certbot certificates -d $host 2>&1 | perl -ne 's/\s+$//g; s/\s+/,/g; print "$1\n" if s/Domains:,(.*)/-d \1/g')"

	[ -z "$curDomains" ] && curDomains="-d $host"

	local CMD="certbot certonly --cert-name $host $curDomains -d $subs -a webroot --webroot-path /etc/letsencrypt/webroot/ --renew-by-default --expand "

	_err $CMD
	vared -p "Execute (type yes)? " -c shouldRun

	[ "$shouldRun" = "yes" ] && $CMD

	unset shouldRun
}
