#!/bin/sh
if [ -z "$(grep ~/private /proc/mounts)" ]; then
	kdialog --title "EncFS" --error "~/private isn't mounted."
	exit
fi
fusermount -u ~/private
