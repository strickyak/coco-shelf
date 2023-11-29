# If you already have a populated `mirror` directory somewhere,
# you can copy it, or symlink it, to avoid fetching packages
# over the internet.
#
# If you already have tarballs of lwtools, cmoc, and gcc-4.6.4
# you can copy them here yourself, to void fetching them
# over the internet.
#
# Notice the subdirectories here are clones of github repositories.
# These will be *copied* to superdirectories.
# So you should "git pull" in these subdirectories,
# or "make pull" in this mirror directory.
#
# "mkdir mirror" yourself and put the tarballs in it, to avoid using
# wget over the internet.  If you already have a "mirror" directory
# somewhere else, you can make a symlink to it.

include ../conf.mk

all: gcc-config-guess $(COCO_LWTOOLS_TARBALL) $(COCO_CMOC_TARBALL) $(COCO_GCCRETRO_TARBALL) FoenixMgr toolshed nitros9 frobio eou-all

# all-anon is an alternataive to "all" that uses your git ssh key.
all-anon:
	make all REPO_PREFIX="https://" REPO_SUFFIX=""

# The gcc-config-guess shipped in the old retro gcc is too old to know
# about Raspberry Pis.  So we need a newer one to replace it.
gcc-config-guess:
	curl 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' > gcc-config-guess

$(COCO_LWTOOLS_TARBALL):
	set -x; test -s $@ || curl $(COCO_LWTOOLS_URL) > $@
$(COCO_CMOC_TARBALL):
	set -x; test -s $@ || curl $(COCO_CMOC_URL) > $@
$(COCO_GCCRETRO_TARBALL):
	set -x; test -s $@ || curl $(COCO_GCCRETRO_URL) > $@
FoenixMgr:
	set -x; test -s $@ || git clone $(COCO_FOENIXMGR_REPO)
toolshed:
	set -x; test -s $@ || git clone $(COCO_TOOLSHED_REPO)
nitros9:
	set -x; test -s $@ || git clone $(COCO_NITROS9_REPO)
frobio:
	set -x; test -s $@ || git clone $(COCO_FROBIO_REPO)

eou-all: eou-h6309.zip eou-m6809.zip

eou-h6309.zip:
	set -x; test -s $@ || curl "$(EOU_H6309_URL)" > $@
eou-m6809.zip:
	set -x; test -s $@ || curl "$(EOU_M6809_URL)" > $@

pull:
	cd FoenixMgr && git pull
	cd toolshed && git pull
	cd nitros9 && git pull
	cd frobio && git pull

clean-mirror:
	rm -f eou-*
	rm -f cmoc-*
	rm -f gcc-*
	rm -f lwtools-*
	rm -rf frobio nitros9 toolshed FoenixMgr
