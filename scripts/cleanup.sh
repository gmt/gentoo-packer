#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	cd /usr/src/linux && make clean
	make prepare || /bin/true
	make archprepare || /bin/true
	make prepare0 || /bin/true
	make prepare1 || /bin/true
	make prepare2 || /bin/true
	make prepare3 || /bin/true
	make modules_prepare
	mkdir -p /etc/portage/profile
	if [[ -f /etc/portage/profile/package.provided ]] ; then
	  cp -v /etc/portage/profile/package.provided{,.packer.bak}
	fi
	echo "$(qlist -ICv sys-kernel/gentoo-sources)" >> /etc/portage/profile/package.provided
	emerge -C sys-kernel/gentoo-sources
	emerge -C virtual/linux-sources
	emerge --depclean
	if [[ -f /etc/portage/profile/package.provided.bak ]] ; then
	  mv -v /etc/portage/profile/package.provided{.packer.bak,}
	else
	  rm -v /etc/portage/profile/package.provided
	  if [[ $(ls -a /etc/portage/profile/package.provided 2>/dev/null | wc -l) -eq 2 ]] ; then
	    rmdir -v /etc/portage/profile
	  fi
	fi
EOF

nukedirs() {
  local thedir
  for thedir in "$@"; do
    echo "Removing \"$thedir\" from image..."
    rm -rf "$thedir"
  done
}

nukedirs /mnt/gentoo/usr/portage
nukedirs /mnt/gentoo/tmp/*
nukedirs /mnt/gentoo/var/log/*
nukedirs /mnt/gentoo/var/tmp/*

chroot /mnt/gentoo /bin/bash <<-EOF
	wget http://intgat.tigress.co.uk/rmy/uml/zerofree-1.0.3.tgz
	tar xvzf zerofree-*.tgz
	cd zerofree*/
	make
EOF

mv /mnt/gentoo/zerofree* ./
cd zerofree*/

echo "Remounting /mnt/gentoo read-only"
mount -o remount,ro /mnt/gentoo
echo "Running: zerofree /dev/sda4..."
./zerofree /dev/sda4

echo "Cleaning up swap..."
swapoff /dev/sda3
dd if=/dev/zero of=/dev/sda3
mkswap /dev/sda3
