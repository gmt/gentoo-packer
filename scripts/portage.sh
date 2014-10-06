#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	mkdir /usr/portage
	emerge-webrsync
	echo "MAKEOPTS=\"${pvmakeopts}\"" >> /etc/portage/make.conf
	echo >> /etc/portage/make.conf
	echo "CFLAGS=\"\\\${CFLAGS} -mtune=core2\"" >> /etc/portage/make.conf
	echo "CXXFLAGS=\"\\\${CXXFLAGS} -mtune=core2\"" >> /etc/portage/make.conf
	echo >> /etc/portage/make.conf
	echo "USE=\"\\\${USE} vim-syntax\"" >> /etc/portage/make.conf
	echo "USE=\"\\\${USE} bash-completion\"" >> /etc/portage/make.conf
	echo >> /etc/portage/make.conf
	echo "EMERGE_DEFAULT_OPTS=\"\\\${EMERGE_DEFAULT_OPTS} --verbose\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} unmerge-orphans\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} parallel-fetch\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} sandbox\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} usersandbox\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} userpriv\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} ipc-sandbox\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} network-sandbox\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} usersync\"" >> /etc/portage/make.conf
	echo "FEATURES=\"\\\${FEATURES} userfetch\"" >> /etc/portage/make.conf
	echo >> /etc/portage/make.conf
	echo "LINGUAS=\"\"" >> /etc/portage/make.conf
	echo >> /etc/portage/make.conf
	echo "INPUT_DEVICES=\"evdev\"" >> /etc/portage/make.conf
	echo >> /etc/portage/make.conf

	sed -e '/^DISTDIR=/d' -i /etc/portage/make.conf
	sed -e '/^PKGDIR=/d' -i /etc/portage/make.conf
	mkdir /usr/portage_distfiles
	mkdir /usr/portage_packages
	echo "DISTDIR=\"/usr/portage_distfiles\"" >> /etc/portage/make.conf
	echo "PKGDIR=\"/usr/portage_packages\"" >> /etc/portage/make.conf
	echo
	echo "RUBY_TARGETS=\"ruby19\"" >> /etc/portage/make.conf
	echo "PYTHON_TARGETS=\"python2_7 python3_3\"" >> /etc/portage/make.conf
	echo "PYTHON_SINGLE_TARGET=\"python2_7\"" >> /etc/portage/make.conf

	echo
	gcc -v
	echo '/etc/portage/make.conf now looks like this:'
	cat /etc/portage/make.conf
	echo '(EOF)'
	echo
EOF
