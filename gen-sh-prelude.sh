#!/bin/sh

# The FoenixMgr sh scripts expect an environment
# variable FOENIXMGR to point to that repo.

# These first three lines should be substituted
# so that `pwd` is replaced with the actual working directory.
# So we spell the end as END without any quoting.

cat <<END
#!/bin/sh
FOENIXMGR='`pwd`/FoenixMgr'
export FOENIXMGR

PATH='`pwd`/bin:/usr/bin:/bin'
export PATH

END
