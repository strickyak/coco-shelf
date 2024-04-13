find . -name .git | while read f ; do d=$(dirname $f) ; echo == $d == ; ( cd $d ; git status ) ; done | less 
