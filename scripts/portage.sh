#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	mkdir /usr/portage
	emerge-webrsync
	echo "MAKEOPTS=\"${pvmakeopts}\"" >> /etc/portage/make.conf
EOF
