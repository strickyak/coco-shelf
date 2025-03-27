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

1. Clone this coco-shelf repo
1. cd into it
1. Execute `sh prepare-ubuntu-24-04.sh`
   (it will need your password to update and install)
1. Execute `make`

Let me know what goes wrong!

It can take 15 minutes or more to build everything,
and it needs perhaps 1.7 GB of disk.

## Example: For Ubuntu 22.10 x64 at Digital Ocean:
On a fresh droplet (under $0.10 per hour, and delete it
within an hour) this works for me:

```
# ---- Install needed linux packages ----
#      (also available in prepare-ubuntu-24-04.sh)
export DEBIAN_FRONTEND=noninteractive
sudo apt -y update < /dev/null
sudo apt -y upgrade < /dev/null
sudo apt -y install gcc make flex bison gdb build-essential
sudo apt -y install git golang zip curl python3-serial
sudo apt -y install libgmp-dev libmpfr-dev libmpc-dev libfuse-dev
sudo apt -y install cmake gcc-arm-none-eabi libusb-1.0-0-dev pkg-config

# ---- Create a user account 'coco' for doing the build ----
useradd --shell /bin/bash -m coco
su - coco

# ---- Do the build ----
git clone https://github.com/strickyak/coco-shelf.git
cd coco-shelf/
make ANON=1 MIRROR=1 all
```

(If you don't have an account on github and that ssh key in your
ssh-agent, add `ANON=1`  to the `make` command line, and it will
clone github repos anonymously, instead of using your account.
Add `MIRROR=1` to fetch from a faster internet site.)

## For MacOS

MacOS can't build the old version of GCC, which is currently
only needed for building the Axiom bootrom in Frobio.

If you can live without that (most of you can),
instead of "make" (which defaults to "make all"),
try making the actual thing you wanted,
like "make FoenixMgr.done".

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

## Re-building portions.

If you delete one of the `*.done` files
( e.g. `cmoc.done frobio.done gccretro.done lwtools.done nitros9.done toolshed.done` )
and type `make`, it will rebuild that portion of the shelf.

If you delete the source directory associated with one of those portions
and type `make`, it will make a new copy of that directory from the
mirror, and rebuild the portion.

## Final Advice on filenames.

Please don't use spaces or shell meta-characters (like parentheses)
in your directory path above `coco-shelf` or in file or directory names
below it.  Shell scripts and Makefiles are simpler and more readable if we
don't need quote marks and other mitigations against weird characters.
Dots and dashes and underscores should be just fine, except at the front
of a name.  Letters and numbers are always good.  No non-ASCII unicode!
