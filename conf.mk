# This is conf.mk for the coco-shelf.
#
# You can edit version numbers to upgrade packages.

S:=$(shell pwd)
export SHELL:=/bin/bash   # Putting this 1st seems to make PATH work.
export HOME:=$S
export PATH:=$S/bin:/usr/bin:/bin

export COCO_LWTOOLS_VERSION:=lwtools-4.21
export COCO_CMOC_VERSION:=cmoc-0.1.85
export COCO_GCCRETRO_VERSION:=gcc-4.6.4

export COCO_LWTOOLS_TARBALL=$(COCO_LWTOOLS_VERSION).tar.gz
export COCO_CMOC_TARBALL=$(COCO_CMOC_VERSION).tar.gz
export COCO_GCCRETRO_TARBALL=$(COCO_GCCRETRO_VERSION).tar.bz2

# If you want to clone these from github with your own git ssh key,
# change REPO_PREFIX to "git@github.com:" and REPO_SUFFIX to ".git".
# Or use the "make all-mine" target, which does this for you.

# If you want to clone these from github anonymously
# (say, if you don't have a github account and the key in your ssh agent),
# change REPO_PREFIX to "https://" and REPO_SUFFIX to "".
# Or use the "make all-anon" target, which does this for you.
REPO_PREFIX=git@github.com:
REPO_SUFFIX=.git
COCO_TOOLSHED_REPO:=$(REPO_PREFIX)nitros9project/toolshed$(REPO_SUFFIX)
COCO_NITROS9_REPO:=$(REPO_PREFIX)nitros9project/nitros9$(REPO_SUFFIX)
COCO_FROBIO_REPO:=$(REPO_PREFIX)strickyak/frobio$(REPO_SUFFIX)

COCO_LWTOOLS_URL:="http://www.lwtools.ca/releases/lwtools/$(COCO_LWTOOLS_TARBALL)"
COCO_CMOC_URL:="http://perso.b2b2c.ca/~sarrazip/dev/$(COCO_CMOC_TARBALL)"
COCO_GCCRETRO_URL:="https://ftp.gnu.org/gnu/gcc/$(COCO_GCCRETRO_VERSION)/$(COCO_GCCRETRO_TARBALL)"

EOU_H6309_URL:=http://www.lcurtisboyle.com/nitros9/EOU_Version%201_0_0_(6309_ONLY)_12-02-2022.zip
EOU_M6809_URL:=http://www.lcurtisboyle.com/nitros9/EOU_Version%201_0_0_(6809_ONLY)_12-02-2022.zip
