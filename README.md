# coco-shelf
A shelf for more-nearly-repeatable coco builds.

Note that the "MIT License" in the file `LICENSE` refers to the
`coco-shelf` repository.  Other packages expanded here have different
licenses, including some code under the GNU General Public License.

# Quick Start

Here are instructions for building on three platforms:
   * Ubuntu Linux on 64-bit Intel or AMD
   * Modern MacOS
   * Raspian OS on a 64-bit Raspberry Pi

## For Ubuntu Linux on 64-bit Intel or AMD
Use a modern Linux distro on an x86_64 platform.
Clone this coco-shelf repo, cd into it, and
just type `make`.  Let me know what goes wrong!

It can take 8 minutes or more to build everything,
and it needs perhaps 1.7 GB of disk.

## Example: For Ubuntu 22.10 x64 at Digital Ocean:
On a fresh droplet (under $0.10 per hour, and delete it
within an hour) this works for me:

```
# ---- Install needed linux packages ----
export DEBIAN_FRONTEND=noninteractive
apt -y update < /dev/null
apt -y upgrade < /dev/null
apt -y install gcc make flex bison gdb build-essential
apt -y install git golang zip curl
apt -y install libgmp-dev libmpfr-dev libmpc-dev

# ---- Create a user account 'coco' for doing the build ----
useradd --shell /bin/bash -m coco
su - coco

# ---- Do the build ----
git clone https://github.com/strickyak/coco-shelf.git
cd coco-shelf/
make
```

(If you don't have an account on github and that ssh key in your
ssh-agent, change the final `make` to `make-anon` and it will
clone github repos anonymously, instead of using your account.)

If that succeeded, the last two lines printed will be
```
make[1]: Leaving directory '/home/coco/coco-shelf/build-frobio'
date > done-frobio
```

Above that it lists the products of the frobio build,
which are in the `build-frobio` directory.

## For MacOS

MacOS can't build the old version of GCC, which is currently
only needed for building the Axiom bootrom in Frobio.

If you can live without that (most of you can),
instead of the final "make", use "make all-without-gccretro".

TODO: Are there any other dependencies or packages to load
for MacOS?  What versions of MacOS does it work on?
Intel CPU or Apple Silicon?

## For Raspberry Pi

Everything builds and works on a Raspberry Pi using
this 64 Bit Lite edition
`2023-05-03-raspios-bullseye-arm64-lite.img.xz`
except don't install the default version of golang.
Theirs is version 1.15 and we need at least 1.18.

Install the same packages listed above for Ubuntu,
except for golang.

Download the latest "arm64" version from https://go.dev/dl/
and untar it in your home.  Notice there will be a
directory go/bin with a binary "go" in it.

Run "make" in the coco-shelf until it crashes for no
go command.  Then create a shell script in coco-shelf/bin
named "go" that runs the one under your home, something
like this:

```
cd $HOME
tar xzf go1.*.linux-amd64.tar.gz
cd coco-shelf
echo ' $HOME/go/bin/go "$@" ' > bin/go
chmod +x bin/go
make
```

## What is the mirror/ directory?

Because you might not be connected to the internet while working on
your CoCo (I often am not), everything you need from the internet is
fetched on your first `make` and cached in the `mirror/` directory.
That includes several tarballs and zips and several github repositories.

If you start a new coco-shelf, you can copy (recursively) the mirror
directory into the new coco-shelf, or symlink it.  That will save time and
bandwidth doing downloads, and will work if you are not on the internet.

## Re-building portions.

If you delete one of the `done-*` files
( `done-cmoc done-frobio done-gccretro done-lwtools done-nitros9 done-toolshed` )
and type `make`, it will rebuild that portion of the shelf.

If you delete the source directory associated with one of those portions
and type `make`, it will make a new copy of that directory from the
mirror, and rebuild the portion.

## Freshening the mirrored portions.

If you want to freshen the git repos in the mirror, you can chdir into
the mirror directory and type `make pull`.  That will do a `git pull`
in each repo.

If you want to use a new version of one of the tarballed portions, change
the version number in `conf.mk` and type `make`.  It should fetch it.

## Final Advice on filenames.

Please don't use spaces or shell meta-characters (like parentheses)
in your directory path above `coco-shelf` or in file or directory names
below it.  Shell scripts and Makefiles are simpler and more readable if we
don't need quote marks and other mitigations against weird characters.
Dots and dashes and underscores should be just fine, except at the front
of a name.  Letters and numbers are always good.  No non-ASCII unicode!
