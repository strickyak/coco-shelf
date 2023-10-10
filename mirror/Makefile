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

all: config.guess $(COCO_LWTOOLS_TARBALL) $(COCO_CMOC_TARBALL) $(COCO_GCCRETRO_TARBALL) toolshed nitros9 frobio eou-all

# The config.guess shipped in the old retro gcc is too old to know
# about Raspberry Pis.  So we need a newer one to replace it.
config.guess:
	curl 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' > config.guess

$(COCO_LWTOOLS_TARBALL):
	set -x; test -s $@ || curl -O $(COCO_LWTOOLS_URL)
$(COCO_CMOC_TARBALL):
	set -x; test -s $@ || curl -O $(COCO_CMOC_URL)
$(COCO_GCCRETRO_TARBALL):
	set -x; test -s $@ || curl -O $(COCO_GCCRETRO_URL)
toolshed:
	set -x; test -s $@ || git clone $(COCO_TOOLSHED_REPO)
nitros9:
	set -x; test -s $@ || git clone $(COCO_NITROS9_REPO)
frobio:
	set -x; test -s $@ || git clone $(COCO_FROBIO_REPO)

eou-all: eou-h6309 eou-m6809

EOU-1.0.0-h6309.zip:
	set -x; test -s $@ || { curl -O "$(EOU_H6309_URL)" && mv -v $(EOU_H6309_ZIP) $@ ;}
EOU-1.0.0-m6809.zip:
	set -x; test -s $@ || { curl -O "$(EOU_M6809_URL)" && mv -v $(EOU_M6809_ZIP) $@ ;}

eou-h6309: EOU-1.0.0-h6309.zip
	rm -rf $@
	mkdir -p $@
	cd $@ && unzip ../$<
eou-m6809: EOU-1.0.0-m6809.zip
	rm -rf $@
	mkdir -p $@
	cd $@ && unzip ../$<

pull:
	cd toolshed && git pull
	cd nitros9 && git pull
	cd frobio && git pull

clean-mirror:
	rm -f cmoc-*
	rm -f gcc-*
	rm -f lwtools-*
	rm -rf frobio nitros9 toolshed
