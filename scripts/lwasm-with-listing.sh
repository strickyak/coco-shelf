#!/bin/sh
set -eu

FOR_ASM=
FOR_O=

for x
do
	case "$x" in
	*.asm )
		set -x
		FOR_ASM="--map=$(basename $x .asm).map --list=$(basename $x .asm).list --list-nofiles"
		set +x
		;;
	-o* )
		set -x
		y=$(expr match "$x" '..\(.*\)')
		FOR_O="--map=$(basename $y).map --list=$(basename $y).list --list-nofiles"
		set +x
		;;
	esac
done

set -eux

# If $FOR_O is non-empty, it takes precedence.
# Else, fall back to $FOR_ASM.
case $FOR_O in
	"" )
		exec lwasm.org "$@" $FOR_ASM
		;;

	* )
		exec lwasm.orig "$@" $FOR_O
		;;
esac
