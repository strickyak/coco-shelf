for cmd in /usr/bin/md5sum /bin/md5sum /usr/bin/md5 /bin/md5 /sbin/md5
do
  if test -x "$cmd"
  then
	set -x ; exec "$cmd" "$@"
  fi
done

echo "ERROR: did not find md5sum nor md5" >&2
exit 13
