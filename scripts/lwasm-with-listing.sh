#!/bin/sh
set -x
export PATH=$(dirname $0):/usr/bin:/bin

XLIST='--list-nofiles'
XLIST=''

FOR_ASM=
FOR_O=
NEXT_O=

for x
do
        case "@$NEXT_O@$x" in
        @1@* )
        	set -x ; #echo {1} >&2
        	FOR_O="--map=$(basename $x).map --list=$(basename $x).list $XLIST"
        	NEXT_O=
        	;;

        @@*.asm )
        	set -x ; #echo {2} >&2
        	FOR_ASM="--map=$(basename $x .asm).map --list=$(basename $x .asm).list $XLIST"
        	;;
        @@-o )
        	set -x ; #echo {3} >&2
        	NEXT_O=1
        	;;
        	
        @@-o* )
        	set -x ; #echo {4} >&2
        	y=$(expr match "$x" '..\(.*\)')
        	FOR_O="--map=$(basename $y).map --list=$(basename $y).list $XLIST"
        	;;
        esac
done

set -eux

# If $FOR_O is non-empty, it takes precedence.
# Else, fall back to $FOR_ASM.
case $FOR_O in
        "" )
        	exec lwasm.orig "$@" $FOR_ASM
        	;;

        * )
        	exec lwasm.orig "$@" $FOR_O
        	;;
esac
