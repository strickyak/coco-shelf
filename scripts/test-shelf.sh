#!/bin/sh
set -eux

ORIG="$PWD"
case $ORIG in
	*/coco-shelf )
		: good
		;;
	* )
		echo "ERROR: You are not in a directory named coco-shelf: $PWD" >&2
		exit 3
		;;
esac

TS=`date +%Y-%m-%d-%H%M%S.$$`
T=/tmp/shelf.$TS

mkdir -p $TS
cd $TS
git clone $ORIG
cd ./coco-shelf
rsync -a $ORIG/mirror/ ./mirror/

PATH=/usr/bin:/bin make
