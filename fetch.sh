#!/bin/bash
set -eux

export SHELF=$(dirname "$0")
export SHELF_TIMESTAMP=$(date +T%s)

cd $SHELF
source ./config.sh

# Fetch tarballs into cache dir.
mkdir -p "$COCO_CACHE_DIR"

test -s "$COCO_CACHE_DIR/$COCO_LWTOOLS_VERSION.tar.gz" ||
  ( cd "$COCO_CACHE_DIR" &&
    wget "$COCO_LWTOOLS_URL" )

test -s "$COCO_CACHE_DIR/$COCO_CMOC_VERSION.tar.gz" ||
  ( cd "$COCO_CACHE_DIR" &&
    wget "$COCO_CMOC_URL" )

test -s "$COCO_CACHE_DIR/$COCO_GCCRETRO_VERSION.tar.bz2" ||
  ( cd "$COCO_CACHE_DIR" &&
    wget "$COCO_GCCRETRO_URL" )

# Unbundle the tarballs.
test -d "$COCO_LWTOOLS_VERSION" ||
  tar xzf "$COCO_CACHE_DIR/$COCO_LWTOOLS_VERSION.tar.gz"

test -d "$COCO_CMOC_VERSION" ||
  tar xzf "$COCO_CACHE_DIR/$COCO_CMOC_VERSION.tar.gz"

test -d "$COCO_GCCRETRO_VERSION" ||
  tar xjf "$COCO_CACHE_DIR/$COCO_GCCRETRO_VERSION.tar.bz2"

# Github.
test -d toolshed || {
  git clone https://github.com/n6il/toolshed toolshed &&
  ( cd toolshed ; git checkout -b $SHELF_TIMESTAMP $COCO_TOOLSHED_COMMIT )
}

test -d nitros9 || {
  git clone https://github.com/n6il/nitros9 &&
  ( cd nitros9 ; git checkout -b $SHELF_TIMESTAMP $COCO_NITROS9_COMMIT )
}

test -d frobio || {
  git clone https://github.com/strickyak/frobio.git &&
  ( cd frobio ; git checkout -b $SHELF_TIMESTAMP $COCO_FROBIO_COMMIT )
}
