#!/bin/sh

# The FoenixMgr sh scripts expect an environment
# variable FOENIXMGR to point to that repo.

# These first three lines should be substituted
# so that `pwd` is replaced with the actual working directory.
# So we spell the end as END without any quoting.

cat <<END
#!/bin/sh
FOENIXMGR=`pwd`/FoenixMgr
export FOENIXMGR

END

# The FoenixMgr sh scripts expect a command python to exist.
# But some systems rename it python3 and delete the old python
# because it is not maintained with security updates.
# The following shell function python() will try to find out
# which name to use.

# The rest should not have any substitutions.
# So we spell the end as 'END' with quotes.

cat <<'END'
python () {
  ok=0
  for p in /bin/python3 /usr/bin/python3 /bin/python /usr/bin/python
  do
    if [ -x $p ]
    then
      ok=1
      $p "$@"
      break
    fi
  done
  if [ "$ok" != "1" ]
  then
    echo "ERROR:  CANNOT FIND python COMMAND" >&2
    exit 13
  fi
}

END
