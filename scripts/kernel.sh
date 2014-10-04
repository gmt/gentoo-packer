#!/bin/bash

cp $SCRIPTS/scripts/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<-EOF
	emerge sys-kernel/gentoo-sources
	emerge sys-kernel/genkernel
	cd /usr/src/linux
	mv /tmp/kernel.config .config
	genkernel --makeopts="${pvmakeopts}" --install --symlink --oldconfig all
	emerge -C sys-kernel/genkernel
EOF
