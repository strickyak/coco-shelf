# This is conf.mk for the coco-shelf.
#
# You can edit version numbers to upgrade packages.

S:=$(shell pwd)
P:=$(shell echo $$PATH)
export SHELF:=$S
export SHELL:=/bin/bash   # Putting this 1st seems to make PATH work.
export PATH:=$S/bin:$P    # Add coco-shelf/bin at front of PATH.
#??# export HOME:=$S

# You have some options, how to clone repositories from github.
# If you append "ANON=1" to the end of your "make" line,
# we will clone the gits anonymously.
# If you don't do that, you will need to have your ssh key for github
# in your ssh-agent.

ifdef ANON

# To fetch anonymously without any ssh key in your ssh-agent:
REPO_PREFIX=https://github.com/
REPO_SUFFIX=

else

# To fetch with your github login, using the key in your ssh-agent:
REPO_PREFIX=git@github.com:
REPO_SUFFIX=.git

endif

# Configure the origins of the gits.
COCO_FOENIXMGR_REPO:=$(REPO_PREFIX)pweingar/FoenixMgr$(REPO_SUFFIX)
COCO_TOOLSHED_REPO:=$(REPO_PREFIX)strickyak/forked-toolshed$(REPO_SUFFIX)
COCO_NITROS9_REPO:=$(REPO_PREFIX)nitros9project/nitros9$(REPO_SUFFIX)
COCO_FROBIO_REPO:=$(REPO_PREFIX)strickyak/frobio$(REPO_SUFFIX)
COCO_GOMAR_REPO:=$(REPO_PREFIX)strickyak/gomar$(REPO_SUFFIX)
COCO_WHIPPETS_REPO:=$(REPO_PREFIX)strickyak/whippets$(REPO_SUFFIX)
COCO_NEKOT_REPO:=$(REPO_PREFIX)strickyak/nekotos$(REPO_SUFFIX)
COCO_BONOBO_REPO:=$(REPO_PREFIX)strickyak/copico-bonobo$(REPO_SUFFIX)
COCO_GODOCLIENT_REPO:=$(REPO_PREFIX)strickyak/godo-client$(REPO_SUFFIX)

# Configure the versions of the tarballs.
COCO_LWTOOLS_VERSION:=lwtools-4.24
COCO_CMOC_VERSION:=cmoc-0.1.90
COCO_GCCRETRO_VERSION:=gcc-4.6.4
COCO_PICOSDK_VERSION:=pico-sdk-2.1.1-thin
COCO_PICOTOOL_VERSION:=picotool-2.1.1-thin

# Add the extensions found on the tarballs.
COCO_LWTOOLS_TARBALL=$(COCO_LWTOOLS_VERSION).tar.gz
COCO_CMOC_TARBALL=$(COCO_CMOC_VERSION).tar.gz
COCO_GCCRETRO_TARBALL=$(COCO_GCCRETRO_VERSION).tar.bz2
COCO_PICOSDK_TARBALL=$(COCO_PICOSDK_VERSION).tar.gz
COCO_PICOTOOL_TARBALL=$(COCO_PICOTOOL_VERSION).tar.gz

# URLS for the tarballs.

ifdef MIRROR

PIZGA_MIRROR_URL:=http://pizga.net/inputs

COCO_CMOC_URL:='$(PIZGA_MIRROR_URL)/$(COCO_CMOC_TARBALL)'
COCO_LWTOOLS_URL:='$(PIZGA_MIRROR_URL)/$(COCO_LWTOOLS_TARBALL)'
COCO_GCCRETRO_URL:='$(PIZGA_MIRROR_URL)/$(COCO_GCCRETRO_TARBALL)'

COCO_PICOSDK_URL:='$(PIZGA_MIRROR_URL)/$(COCO_PICOSDK_TARBALL)'
COCO_PICOTOOL_URL:='$(PIZGA_MIRROR_URL)/$(COCO_PICOTOOL_TARBALL)'

EOU_H6309_URL:='$(PIZGA_MIRROR_URL)/eou-h6309.zip'
EOU_M6809_URL:='$(PIZGA_MIRROR_URL)/eou-m6809.zip'
EOU_101_H6309_URL:='$(PIZGA_MIRROR_URL)/eou-101-h6309.zip'
EOU_101_M6809_URL:='$(PIZGA_MIRROR_URL)/eou-101-m6809.zip'

else

# OBTW # http://gvlsywt.cluster051.hosting.ovh.net/dev/cmoc.html (since Google doesn't know it)
COCO_CMOC_URL:="http://gvlsywt.cluster051.hosting.ovh.net/dev/$(COCO_CMOC_TARBALL)"
COCO_LWTOOLS_URL:="http://www.lwtools.ca/releases/lwtools/$(COCO_LWTOOLS_TARBALL)"
COCO_GCCRETRO_URL:="https://ftp.gnu.org/gnu/gcc/$(COCO_GCCRETRO_VERSION)/$(COCO_GCCRETRO_TARBALL)"

COCO_PICOSDK_URL:="http://pizga.net/inputs/$(COCO_PICOSDK_TARBALL)"
COCO_PICOTOOL_URL:="http://pizga.net/inputs/$(COCO_PICOTOOL_TARBALL)"

EOU_H6309_URL:='http://www.lcurtisboyle.com/nitros9/EOU_Version%201_0_0_(6309_ONLY)_12-02-2022.zip'
EOU_M6809_URL:='http://www.lcurtisboyle.com/nitros9/EOU_Version%201_0_0_(6809_ONLY)_12-02-2022.zip'
EOU_101_H6309_URL:='http://www.lcurtisboyle.com/nitros9/EOU_Version1_0_1_(6309_ONLY)_04-07-2024.zip'
EOU_101_M6809_URL:='http://www.lcurtisboyle.com/nitros9/EOU_Version1_0_1_(6809_ONLY)_04-07-2024.zip'

endif
