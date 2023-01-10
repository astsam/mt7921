#!/bin/bash

set -e

pwd=`pwd`
script_dir="$( cd "$( dirname "$0" )" && pwd )"

if [[ -d /lib/firmware/mediatek ]]; then
	cp -f ${script_dir}/../fw/* $KLIB/lib/firmware/mediatek/
fi

