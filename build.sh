#!/bin/bash
set -eux

case $# in
  1) COMMAND="$1" ;;
  0) COMMAND= ;;
  *)
      echo ERROR: Unexpected Arguments >&2
      exit 13
      ;;
esac

case $COMMAND in
  doit)
    : ok good
    ;;
  XXXclean)
    rm -f done-*
    rm -rf bin lib usr share libexec cache
    rm -rf lwtools-*[0-9]
    rm -rf cmoc-*[0-9]
    rm -rf toolshed nitros9 gcc-4.6.4 gcc-4.6.4-build
    exit 0 ;;
  with-no-env)
    env -i - PATH="/bin:/usr/bin" bash "$0" doit
    exit $?
    ;;
  *)
    echo "Do not run $0 yourself." >&2
    echo "Use 'make' to run it."
    exit 13
    ;;
esac
env | cat -n

mkdir -p bin lib share cache
mkdir -p src/github.com/strickyak/
rm -f usr
ln -s . usr

export SHELF="$(/bin/pwd)"
export GOPATH="$SHELF"
# export GOPATH="${GOPATH:-$HOME/go}:$PWD"
export GOBIN="$SHELF/bin"
export GOCACHE="$SHELF/cache"
export PATH="$SHELF/bin:/bin:/usr/bin"

function fail () {
  echo ERROR: "$*" >&2
  exit 13
}

# Expect exactly one tar file like this:
#   lwtools-4.21.tar.gz
# Download from http://www.lwtools.ca/

function build_lwtools () {
  #set lwtools*.tar.gz
  #expr match "$#/$*" '^1/lwtools-[0-9.]*.tar.gz$' ||
  #  fail "Expected one file matching /lwtools-[0-9.]*.tar.gz$/ but got '$*'"

  #tar xzf "$1"
  (
    cd lwtools-*/.
    make PREFIX="$SHELF"
    make PREFIX="$SHELF" install
  )
  date > done-lwtools
}

# Find CMOC at http://sarrazip.com/dev/cmoc.html
# Download exactly one tar file like this:

function build_cmoc () {
  #set cmoc*.tar.gz
  #expr match "$#/$*" '^1/cmoc-[0-9.]*.tar.gz$' ||
  #  fail "Expected one file matching /lwtools-[0-9.]*.tar.gz$/ but got '$*'"

  #tar xzf "$1"
  (
    cd cmoc-*/.
    ./configure --prefix="$SHELF"
    make all
    make install
  )
  date > done-cmoc
}

# Mikey N6IL has a copy of toolshed in their github.
function build_toolshed () {
  #git clone https://github.com/n6il/toolshed
  (
    cd toolshed
    make -C build/unix DESTDIR="$SHELF" all
    make -C build/unix DESTDIR="$SHELF" install
  )
  date > done-toolshed
}

# Mikey N6IL has a copy of nitros9 in their github.
function build_nitros9 () {
  #test -d nitros9 || git clone https://github.com/n6il/nitros9
  (
    cd nitros9
    make PORTS="coco1" dsk
    make PORTS="coco3" dsk
  )
  date > done-nitros9
}

function build_gcc6809 () {
  # Hints from https://raw.githubusercontent.com/beretta42/fip/master/docs/build_fuzix.txt
  #test -d gcc-4.6.4 || {
  #  rm -rf gcc-4.6.4 gcc-4.6.4-build
  #  tar xjf gcc-4.6.4.tar.bz2
  #  set x lwtools-*[0-9]
  #  wc $2/extra/gcc6809lw-4.6.4-9.patch /dev/null
  #  ( cd gcc-4.6.4 && patch -p1 < ../$2/extra/gcc6809lw-4.6.4-9.patch )
  #  cp $2/extra/as bin/m6809-unknown-as
  #  cp $2/extra/ld bin/m6809-unknown-ld
  #  cp $2/extra/ar bin/m6809-unknown-ar
  #  ln -s /bin/true bin/m6809-unknown-ranlib
  #}
  mkdir -p gcc-4.6.4-build
  (
    cd gcc-4.6.4-build

    ../gcc-4.6.4/configure \
      --prefix="$SHELF" \
      --enable-languages=c \
      --target=m6809-unknown \
      --disable-libada \
      --program-prefix=m6809-unknown- \
      --enable-obsolete \
      --disable-threads \
      --disable-nls \
      --disable-libssp \
      --with-as=$SHELF/bin/m6809-unknown-as \
      --with-ld=$SHELF/bin/m6809-unknown-ld \
      --with-ar=$SHELF/bin/m6809-unknown-ar

    time make all-gcc 2>&1 | tee /tmp/gcc.log

    echo "// This is a kludge, not the real limits.h" > gcc/include-fixed/limits.h
    echo "#!/bin/sh
          echo // This is a kludge, not the output of makeinfo." >> ../bin/makeinfo
    chmod +x ../bin/makeinfo

    time make all-target-libgcc 2>&1 | tee /tmp/all-target-libgcc.log
    time make install-gcc 2>&1 | tee /tmp/install-gcc.log
    time make install-target-libgcc 2>&1 | tee /tmp/install-target-libgcc.log

    rm ../bin/makeinfo
  )
  rm -f bin/gcc6809
  ln -s m6809-unknown-gcc bin/gcc6809
  date > done-gcc6809
}

# Strick has the frobio repo in their github.
function build_frobio () {
  mkdir -p src/github.com/strickyak/
  (
    # export GOPATH="${GOPATH:-$HOME/go}:$PWD"
    cd src/github.com/strickyak/
    test -d frobio || git clone https://github.com/strickyak/frobio.git
    (cd frobio/frob2 && make -B)
    (cd frobio/frob2/drivers && make -B)
    (cd frobio/frob2/fuse && make -B)
    (cd frobio/frob2 && make -B 3)
    (cd frobio/frob2/fcl && /opt/yak/go/bin//go env && /opt/yak/go/bin//go install)
  )
  date > done-frobio
}

test -f done-lwtools || build_lwtools
test -f done-cmoc || build_cmoc
test -f done-toolshed || build_toolshed
test -f done-nitros9 || build_nitros9
test -f done-gcc6809 || build_gcc6809
test -f done-frobio || build_frobio
