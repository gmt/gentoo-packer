#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	emerge --noreplace "app-editors/nano"
	emerge "app-editors/vim"
EOF
