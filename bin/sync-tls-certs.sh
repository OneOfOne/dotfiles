#!/bin/zsh
set -e

pushd ~/.dotfiles/tls

sudo -uoneofone rsync -aL root@oneofone.dev:/etc/letsencrypt/live/oneofone.dev-0001/{privkey,fullchain}.pem .

mv privkey.pem oneofone_dev.key
mv fullchain.pem oneofone_dev.crt

chmod 644 oneofone_dev.*

sudo -uprosody cp -av oneofone_dev.* /etc/prosody/certs

popd
