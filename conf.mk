# This is conf.mk for the coco-shelf.
#
# You can edit version numbers to upgrade packages.

S:=$(shell pwd)
export SHELL:=/bin/bash   # Putting this 1st seems to make PATH work.
export HOME:=$S
export PATH:=$S/bin:/usr/bin:/bin

export COCO_LWTOOLS_VERSION:=lwtools-4.21
export COCO_CMOC_VERSION:=cmoc-0.1.83
export COCO_GCCRETRO_VERSION:=gcc-4.6.4

export COCO_LWTOOLS_TARBALL=$(COCO_LWTOOLS_VERSION).tar.gz
export COCO_CMOC_TARBALL=$(COCO_CMOC_VERSION).tar.gz
export COCO_GCCRETRO_TARBALL=$(COCO_GCCRETRO_VERSION).tar.bz2

COCO_TOOLSHED_REPO:=https://github.com/n6il/toolshed
COCO_NITROS9_REPO:=https://github.com/n6il/nitros9
COCO_FROBIO_REPO:=https://github.com/strickyak/frobio

COCO_LWTOOLS_URL:="http://www.lwtools.ca/releases/lwtools/$(COCO_LWTOOLS_TARBALL)"
COCO_CMOC_URL:="http://perso.b2b2c.ca/~sarrazip/dev/$(COCO_CMOC_TARBALL)"
COCO_GCCRETRO_URL:="https://ftp.gnu.org/gnu/gcc/$(COCO_GCCRETRO_VERSION)/$(COCO_GCCRETRO_TARBALL)"
