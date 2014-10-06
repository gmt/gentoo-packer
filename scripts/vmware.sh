#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	echo >> /etc/portage/make.conf
	echo "VIDEO_CARDS=\"\\\${VIDEO_CARDS} vmware\"" >> /etc/portage/make.conf
	echo "INPUT_DEVICES=\"\\\${INPUT_DEVICES} vmmouse\"" >> /etc/portage/make.conf

	# TODO: Install open-vm-tools
EOF
