# This is Makefile for the coco-shelf.
#
#        https://github.com/strickyak/coco-shelf
#
# The coco-shelf helps you build packages associated with Nitros9
# (especially strick's frobio networking packages)
# in a standard and (mostly) repeatable way on modern Linux machines.

# You can edit version numbers in here, to upgrade to newer packages:
include conf.mk

# For calling make from a subdirectory, with coco-shelf as HOME and limited PATH.
# We use coco-shelf as HOME to avoid differences due to personal dot-files.
# We fix the PATH to avoid differences due to a personal non-standard PATH.
RUN_MAKE = HOME="`cd .. && pwd`" PATH="`cd .. && pwd`/bin:/usr/bin:/bin" make

all: done-lwtools done-cmoc done-gccretro done-toolshed done-nitros9 done-frobio

# If you already have tarballs of lwtools, cmoc, and gcc-4.6.4
# you can "mkdir mirror" yourself and put the tarballs in it,
# to avoid using wget over the internet.  If you already have a
# "mirror" directory somewhere else, you can make a symlink to it.
mirror:
	mkdir -p mirror
mirror/$(COCO_LWTOOLS_TARBALL): mirror
	set -x; test -s $@ || (cd mirror && wget $(COCO_LWTOOLS_URL))
mirror/$(COCO_CMOC_TARBALL): mirror
	set -x; test -s $@ || (cd mirror && wget $(COCO_CMOC_URL))
mirror/$(COCO_GCCRETRO_TARBALL): mirror
	set -x; test -s $@ || (cd mirror && wget $(COCO_GCCRETRO_URL))
mirror/toolshed: mirror
	cd mirror && git clone $(COCO_TOOLSHED_REPO)
mirror/nitros9: mirror
	cd mirror && git clone $(COCO_NITROS9_REPO)
mirror/frobio: mirror
	cd mirror && git clone $(COCO_FROBIO_REPO)

$(COCO_LWTOOLS_VERSION): mirror/$(COCO_LWTOOLS_TARBALL)
	set -x; test -d $@ || tar -xzf mirror/$(COCO_LWTOOLS_TARBALL)
$(COCO_CMOC_VERSION): mirror/$(COCO_CMOC_TARBALL)
	set -x; test -d $@ || tar -xzf mirror/$(COCO_CMOC_TARBALL)
$(COCO_GCCRETRO_VERSION): mirror/$(COCO_GCCRETRO_TARBALL) $(COCO_LWTOOLS_VERSION) 
	set -x; test -d $@ || tar -xjf mirror/$(COCO_GCCRETRO_TARBALL)
	cd $@ && patch -p1 < ../$(COCO_LWTOOLS_VERSION)/extra/gcc6809lw-4.6.4-9.patch
	mkdir -p bin
	cp $(COCO_LWTOOLS_VERSION)/extra/as bin/m6809-unknown-as
	cp $(COCO_LWTOOLS_VERSION)/extra/ld bin/m6809-unknown-ld
	cp $(COCO_LWTOOLS_VERSION)/extra/ar bin/m6809-unknown-ar
	set -x; test -s bin/m6809-unknown-ranlib || ln -s /bin/true bin/m6809-unknown-ranlib
	set -x; test -s bin/makeinfo || ln -s /bin/true bin/makeinfo
toolshed:
	cp -a mirror/$@ .
nitros9:
	cp -a mirror/$@ .
frobio:
	cp -a mirror/$@ .

done-frobio: frobio
	test -s bin/gcc6809 || ln -s m6809-unknown-gcc-4.6.4 bin/gcc6809
	mkdir -p build-frobio
	SHELF=`pwd`; cd build-frobio && HOME=/dev/null PATH="$$SHELF/bin:/usr/bin:/bin" ../frobio/frob3/configure --nitros9="$$SHELF/nitros9"
	SHELF=`pwd`; cd build-frobio && $(RUN_MAKE) 2>&1 | tee log
	date > done-frobio

done-toolshed: toolshed
	test -d usr || ln -s . usr
	SHELF=`pwd`; cd toolshed && $(RUN_MAKE) -C build/unix DESTDIR="$$SHELF" all 2>&1 | tee log
	SHELF=`pwd`; cd toolshed && $(RUN_MAKE) -C build/unix DESTDIR="$$SHELF" install 2>&1 | tee log-install
	date > done-toolshed

done-nitros9: nitros9
	cd nitros9 && NITROS9DIR=`pwd` $(RUN_MAKE) PORTS=coco1 dsk 2>&1 | tee log-coco1
	cd nitros9 && NITROS9DIR=`pwd` $(RUN_MAKE) PORTS=coco3 dsk 2>&1 | tee log-coco3
	cd nitros9 && NITROS9DIR=`pwd` $(RUN_MAKE) PORTS=coco3_6309 dsk 2>&1 | tee log-coco3_6809
	date > done-nitros9

done-lwtools: $(COCO_LWTOOLS_VERSION)
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" all) 2>&1 | tee log
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" install) 2>&1 | tee log-install
	date > done-lwtools

done-cmoc: $(COCO_CMOC_VERSION)
	set -x; SHELF=`pwd`; (cd $< && PATH="$(PATH)" ./configure --prefix="$$SHELF")
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" all) 2>&1 | tee log
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" install) 2>&1 | tee log-install
	date > done-cmoc

done-gccretro: $(COCO_GCCRETRO_VERSION)
	echo PATH -- $$PATH -- PATH
	which makeinfo
	mkdir -p build-$(COCO_GCCRETRO_VERSION)
	SHELF=`pwd`; cd build-$< && PATH="$(PATH)" ../gcc-4.6.4/configure \
      --prefix="$$SHELF" \
      --enable-languages=c \
      --target=m6809-unknown \
      --disable-libada \
      --program-prefix=m6809-unknown- \
      --enable-obsolete \
      --disable-threads \
      --disable-nls \
      --disable-libssp \
      --with-as="$$SHELF/bin/m6809-unknown-as" \
      --with-ld="$$SHELF/bin/m6809-unknown-ld" \
      --with-ar="$$SHELF/bin/m6809-unknown-ar"
	cd build-$< && $(RUN_MAKE) MAKEINFO=true all-gcc 2>&1 | tee log-allgcc
	cd build-$< && echo "// This is a kludge, not the real limits.h" > gcc/include-fixed/limits.h
	cd build-$< && $(RUN_MAKE) MAKEINFO=true all-target-libgcc 2>&1 | tee log-all-target-libgcc
	cd build-$< && $(RUN_MAKE) MAKEINFO=true install-gcc 2>&1 | tee log-install-gcc
	cd build-$< && $(RUN_MAKE) MAKEINFO=true install-target-libgcc 2>&1 | tee log-install-target-libgcc
	date > done-gccretro

clean-shelf:
	-rm -rf bin shared lib libexec usr
	-rm -rf cmoc-0.1.82
	-rm -f done-*
	-rm -rf lwtools-4.21
# END.
