#!/bin/sh
set -eu
export PATH="$(dirname $0):/usr/bin:/bin"

XLIST='--list-nofiles'
XLIST=''

FOR_ASM=
FOR_O=
NEXT_O=

for x
do
        case "@$NEXT_O@$x" in
        @1@* )
        	FOR_O="--map=$(basename $x).map --list=$(basename $x).list $XLIST"
        	NEXT_O=
        	;;

        @@*.asm )
        	FOR_ASM="--map=$(basename $x .asm).map --list=$(basename $x .asm).list $XLIST"
        	;;
        @@-o )
        	NEXT_O=1
        	;;
        	
        @@-o* )
        	y=$(expr "X$x" : 'X..\(.*\)')
        	FOR_O="--map=$(basename $y).map --list=$(basename $y).list $XLIST"
        	;;
        esac
done

# If $FOR_O is non-empty, it takes precedence.
# Else, fall back to $FOR_ASM.
case $FOR_O in
        "" )
		set -eux
        	exec lwasm.orig "$@" $FOR_ASM
        	;;

        * )
		set -eux
        	exec lwasm.orig "$@" $FOR_O
        	;;
esac
