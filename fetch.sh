#!/bin/bash
set -eux

export SHELF=$(dirname "$0")
export SHELF_TIMESTAMP=$(date +T%s)

cd $SHELF
source ./config.sh

# Tarballs Mirrors.
mkdir -p "$COCO_MIRROR"

test -s "$COCO_MIRROR/$COCO_LWTOOLS_VERSION.tar.gz" ||
  ( cd "$COCO_MIRROR" &&
    wget "$COCO_LWTOOLS_URL" )

test -s "$COCO_MIRROR/$COCO_CMOC_VERSION.tar.gz" ||
  ( cd "$COCO_MIRROR" &&
    wget "$COCO_CMOC_URL" )

test -s "$COCO_MIRROR/$COCO_GCCRETRO_VERSION.tar.bz2" ||
  ( cd "$COCO_MIRROR" &&
    wget "$COCO_GCCRETRO_URL" )

# Unbundle the tarballs.
test -d "$COCO_LWTOOLS_VERSION" ||
  tar xzf "$COCO_MIRROR/$COCO_LWTOOLS_VERSION.tar.gz"

test -d "$COCO_CMOC_VERSION" ||
  tar xzf "$COCO_MIRROR/$COCO_CMOC_VERSION.tar.gz"

test -d "$COCO_GCCRETRO_VERSION" ||
  tar xjf "$COCO_MIRROR/$COCO_GCCRETRO_VERSION.tar.bz2"

# Github Mirrors.
test -d "$COCO_MIRROR/toolshed" ||
  ( cd "$COCO_MIRROR" &&
    git clone --mirror $COCO_TOOLSHED_REPO toolshed )

test -d "$COCO_MIRROR/nitros9" ||
  ( cd "$COCO_MIRROR" &&
    git clone --mirror $COCO_NITROS9_REPO nitros9 )

test -d "$COCO_MIRROR/frobio" ||
  ( cd "$COCO_MIRROR" &&
    git clone --mirror $COCO_FROBIO_REPO frobio )

# Github.
test -d toolshed || {
  git clone "$COCO_MIRROR/toolshed" toolshed &&
  ( cd toolshed ; git checkout -b $SHELF_TIMESTAMP $COCO_TOOLSHED_COMMIT )
}

test -d nitros9 || {
  git clone "$COCO_MIRROR/nitros9" &&
  ( cd nitros9 ; git checkout -b $SHELF_TIMESTAMP $COCO_NITROS9_COMMIT )
}

test -d frobio || {
  git clone "$COCO_MIRROR/frobio" &&
  ( cd frobio ; git checkout -b $SHELF_TIMESTAMP $COCO_FROBIO_COMMIT )
}
