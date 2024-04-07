# stop breaking servers with docker and iptables/nftables

Add `"iptables": false` to `/etc/docker/daemon.json` to disable docker from editing the firewall settings.


