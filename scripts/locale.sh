#!/bin/bash

prov_locale="${PROV_LOCALE}"
prov_locale="${prov_locale// /[[:space:]]}"
prov_locale="${prov_locale//./\\.}"

chroot /mnt/gentoo /bin/bash <<-EOF
	if [[ $( cat /etc/locale.gen | \
	           egrep "^[[:space:]]*${prov_locale}[[:space:]]*\$" | \
	             wc -l ) -eq 0 ]]
	then
	  sed -e "/^[[:space:]]*${prov_locale%[[:space:\]\]*}\\([[:space:]]\\|\$\\)/d"
	      -i /etc/locale.gen
	  echo "${PROV_LOCALE}" >> /etc/locale.gen
	fi
	locale-gen
	eselect locale set "${PROV_LOCALE% *}"
	env-update
EOF
