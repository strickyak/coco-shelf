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

all: mirror-stuff done-eou done-lwtools done-cmoc done-gccretro done-toolshed done-nitros9 done-frobio
all-without-gccretro: mirror-stuff done-eou done-lwtools done-cmoc done-toolshed done-nitros9 done-frobio-without-gccretro
all-without-gccretro-frobio: mirror-stuff done-eou done-lwtools done-cmoc done-toolshed done-nitros9

# all-anon is an alternataive to "all" that does not use your git ssh key.
all-anon:
	make all REPO_PREFIX="https://github.com/" REPO_SUFFIX=""

run-lemma: all-without-gccretro
	make -C build-frobio run-lemma

# If you already have tarballs of lwtools, cmoc, and gcc-4.6.4
# you can "mkdir mirror" yourself and put the tarballs in it,
# to avoid using wget over the internet.  If you already have a
# "mirror" directory somewhere else, you can make a symlink to it.

mirror-stuff:
	make -C mirror

mirror-pull:
	make -C mirror pull

lwtools:
	set -x; test -d $@ || tar -xzf mirror/$(COCO_LWTOOLS_TARBALL) && mv -v $(COCO_LWTOOLS_VERSION) $@
cmoc:
	set -x; test -d $@ || tar -xzf mirror/$(COCO_CMOC_TARBALL) && mv -v $(COCO_CMOC_VERSION) $@
gccretro:
	set -x; test -d $@ || tar -xjf mirror/$(COCO_GCCRETRO_TARBALL) && mv -v $(COCO_GCCRETRO_VERSION) $@ && \
	      (cd $@ && patch -p1 < ../lwtools/extra/gcc6809lw-4.6.4-9.patch)
	mkdir -p bin
	cp -f -v mirror/gcc-config-guess "$@/config.guess"
	cp -f -v mirror/gcc-config-guess "$@/libjava/libltdl/config.guess"
	cp -f -v mirror/gcc-config-guess "$@/libjava/classpath/config.guess"
	cp lwtools/extra/as bin/m6809-unknown-as
	cp lwtools/extra/ld bin/m6809-unknown-ld
	cp lwtools/extra/ar bin/m6809-unknown-ar
	set -x; test -s bin/m6809-unknown-ranlib || ln -s /bin/true bin/m6809-unknown-ranlib
	set -x; test -s bin/makeinfo || ln -s /bin/true bin/makeinfo
toolshed:
	set -x; test -s $@ || cp -a mirror/$@ .
nitros9:
	set -x; test -s $@ || cp -a mirror/$@ .
frobio:
	set -x; test -s $@ || cp -a mirror/$@ .

done-frobio: frobio
	test -s bin/gcc6809 || ln -s m6809-unknown-$(COCO_GCCRETRO_VERSION) bin/gcc6809
	mkdir -p build-frobio
	SHELF=`pwd`; cd build-frobio && HOME=/dev/null PATH="$$SHELF/bin:/usr/bin:/bin" ../frobio/frob3/configure --nitros9="$$SHELF/nitros9"
	SHELF=`pwd`; cd build-frobio && $(RUN_MAKE)
	date > done-frobio

done-frobio-without-gccretro: frobio
	mkdir -p build-frobio
	SHELF=`pwd`; cd build-frobio && HOME=/dev/null PATH="$$SHELF/bin:/usr/bin:/bin" ../frobio/frob3/configure --nitros9="$$SHELF/nitros9"
	SHELF=`pwd`; cd build-frobio && $(RUN_MAKE) all-without-gccretro
	date > done-frobio

done-toolshed: toolshed
	test -d usr || ln -s . usr
	SHELF=`pwd`; cd toolshed && $(RUN_MAKE) -C build/unix DESTDIR="$$SHELF" all
	SHELF=`pwd`; cd toolshed && $(RUN_MAKE) -C build/unix DESTDIR="$$SHELF" install
	date > done-toolshed

done-nitros9: nitros9
	cd nitros9 && NITROS9DIR=`pwd` $(RUN_MAKE) PORTS=coco1 dsk
	cd nitros9 && NITROS9DIR=`pwd` $(RUN_MAKE) PORTS=coco3 dsk
	cd nitros9 && NITROS9DIR=`pwd` $(RUN_MAKE) PORTS=coco3_6309 dsk
	date > done-nitros9

done-lwtools: lwtools
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" all)
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" install)
	date > done-lwtools

done-cmoc: cmoc
	set -x; SHELF=`pwd`; (cd $< && PATH="$(PATH)" ./configure --prefix="$$SHELF")
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" all)
	set -x; SHELF=`pwd`; (cd $< && $(RUN_MAKE) PREFIX="$$SHELF" install)
	date > done-cmoc

done-gccretro: gccretro
	echo PATH -- $$PATH -- PATH
	which makeinfo
	mkdir -p build-$<
	SHELF=`pwd`; cd build-$< && PATH="$(PATH)" ../gccretro/configure \
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
	cd build-$< && $(RUN_MAKE) MAKEINFO=true all-gcc
	cd build-$< && echo "// This is a kludge, not the real limits.h" > gcc/include-fixed/limits.h
	cd build-$< && $(RUN_MAKE) MAKEINFO=true all-target-libgcc
	cd build-$< && $(RUN_MAKE) MAKEINFO=true install-gcc
	cd build-$< && $(RUN_MAKE) MAKEINFO=true install-target-libgcc
	date > done-gccretro

done-eou: eou-h6309 eou-m6809
	date > done-eou
eou-h6309: mirror/eou-h6309.zip
	rm -rf $@
	mkdir -p $@
	cd $@ && unzip ../$<
eou-m6809: mirror/eou-m6809.zip
	rm -rf $@
	mkdir -p $@
	cd $@ && unzip ../$<

clean-shelf:
	rm -rf build-* done-*
	rm -rf bin share lib libexec usr include .cache
	rm -rf cmoc frobio gccretro lwtools m6809-unknown nitros9 toolshed
	rm -rf eou-h6309 eou-m6809
