#!/bin/bash

set -e

source ./scripts/mod_helpers.sh

if test "$(mod_filename mt76)" = "mt76.ko.gz" ; then
	compr=".gz"
elif test "$(mod_filename mt76)" = "mt76.ko.xz" ; then
	compr=".xz"
else
	compr=""
fi

for driver in $(find ${BACKPORT_DIR} -type f -name *.ko); do
	mod_name=${driver/${BACKPORT_DIR}/${KLIB}${KMODDIR}}${compr}
	echo "  uninstall" $mod_name
	rm -f $mod_name
done
