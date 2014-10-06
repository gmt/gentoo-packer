#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	echo >> /etc/portage/make.conf
	echo "VIDEO_CARDS=\"\\\${VIDEO_CARDS} virtualbox\"" >> /etc/portage/make.conf
	echo "INPUT_DEVICES=\"\\\${INPUT_DEVICES} virtualbox\"" >> /etc/portage/make.conf

	# install virtualbox guest additions
	emerge "=virtual/linux-sources-1" --autounmask-write
	etc-update --automode -5
	emerge "=virtual/linux-sources-1" --oneshot

	emerge ">=app-emulation/virtualbox-guest-additions-4.3" --autounmask-write
	etc-update --automode -5
	emerge ">=app-emulation/virtualbox-guest-additions-4.3"

	rc-update add virtualbox-guest-additions default
EOF
