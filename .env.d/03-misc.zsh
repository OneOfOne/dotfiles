export WINEDEBUG=-all
export WINEDLLOVERRIDES=winemenubuilder.exe=d
export WINE_CPU_TOPOLOGY="16:0,1,2,3,4,5,6,7,16,17,18,19,20,21,22,23"
export VKD3D_SHADER_CACHE_PATH=/tmp
export DXVK_STATE_CACHE_PATH=/tmp
# export DXVK_FRAME_RATE=120
# export VKD3D_FRAME_RATE=120

export HISTFILE="$HOME/.cache/zsh/history"

function dig-any {
	command dig $@ ANY | grep -v -E '^$|^;'
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

function qemu-uefi() {
	local bios=uefi_vars.fd
	if [ ! -f uefi_vars.fd ]; then
		bios=/tmp/uefi_vars.fd
		_err "no uefi_vars.fd, using $bios"
		[ ! -f $bios ] && cp -v /usr/share/ovmf/x64/OVMF_VARS.fd $bios
	fi

	mkdir qemu-shared &>/dev/null

	local args=()
	local ignore=0

	for arg in $@; do
		if [ "$ignore" = 1 ]; then
			ignore=0
		elif [[ "$arg" =~ "\.iso$" ]]; then
			args+=(-drive)
			arg="file=$arg,media=cdrom"
		elif [[ "$arg" =~ "^/dev/" ]]; then
			args+=(-drive)
			arg="file=$arg,format=raw,if=virtio,aio=native,cache=none"
		elif [[ "$arg" =~ "^-" ]]; then
			ignore=1
		fi

		args+=($arg)
	done

	set -x

	QEMU_AUDIO_DRV=pa sudo qemu-system-x86_64 -enable-kvm -m 16G \
		-machine q35,accel=kvm -cpu host -smp 8 \
		-device virtio-balloon -vga virtio \
		-object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 \
		-drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF_CODE.fd \
		-drive if=pflash,format=raw,file=$bios \
		-fsdev local,security_model=passthrough,id=fsdev0,path=qemu-shared \
		-device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
		$args
}

function tmuxs() {
	tmux new -A -s $(basename $PWD)
}
