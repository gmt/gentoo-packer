#!/bin/bash

if [[ -z $STAGE3 ]]
then
  echo "STAGE3 environment variable must be set to a timestamp."
  exit 1
fi

if [[ -z $SCRIPTS ]]
then
  SCRIPTS=.
fi

pvmakeopts=-j1
if [[ $PARALLELISM -gt 1 ]]
then
  pvmakeopts="-j$(( PARALLELISM + 1))"
fi

export pvmakeopts
export STAGE3
export SCRIPTS

chmod +x $SCRIPTS/scripts/*.sh

for script in \
  partition   \
  stage3      \
  mounts      \
  resolv.conf \
  portage     \
  timezone    \
  fstab       \
  kernel      \
  grub        \
  $VM_TYPE    \
  network     \
  vim         \
  vagrant     \
  cleanup
do
  echo "========================================="
  echo "= Doing the ${script} stuff"
  echo "========================================="
  "$SCRIPTS/scripts/$script.sh"
done

echo "All done."
