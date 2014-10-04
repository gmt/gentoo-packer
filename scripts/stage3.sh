#!/bin/bash

tarball=stage3-amd64-nomultilib-$STAGE3.tar.bz2

mount /dev/sda4 /mnt/gentoo

cd /mnt/gentoo
wget -q "http://distfiles.gentoo.org/releases/amd64/autobuilds/$STAGE3/$tarball" -O - | tar xvjpf - -C /mnt/gentoo

echo ">> ls -l /mnt/gentoo:"

ls -l /mnt/gentoo

echo

