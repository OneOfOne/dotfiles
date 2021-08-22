#!/bin/sh
if [ -n "$(grep ~/private /proc/mounts)" ]; then
	xmessage "~/private is already mounted."
	exit 1
fi

if [ -z "$DISPLAY" ]; then
	encfs ~/.private ~/private
else
	encfs --extpass="kdialog --title EncFS --password 'Encryption Password:'" ~/.private ~/private
fi
