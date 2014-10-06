#!/bin/bash

chroot /mnt/gentoo /bin/bash <<-EOF
	emerge -DuN '@world' \
	  --autounmask-write \
	  --changed-use \
	  --accept-properties=-interactive || /bin/true
	etc-update --automode -5
	FEATURES="parallel-install" emerge -DuN '@world' \
	  --changed-use \
	  --accept-properties=-interactive \
	  --jobs="${pvmakeopts#-j}" \
	  --quiet-fail=y \
	  --fail-clean=y \
	  --keep-going=y || /bin/true
EOF
