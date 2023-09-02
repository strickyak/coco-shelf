# coco-shelf
A shelf for more-nearly-repeatable coco builds.

Note that the "MIT License" in thie file `LICENSE` refers to the
`coco-shelf` repository.  Other packages expaneded here have different
licenses, including some code under the GNU General Public License.

## Quick Start
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
apt -y install gcc gcc-doc make flex bison gdb build-essential
apt -y install git git-doc golang golang-doc
apt -y install libgmp-dev libmpfr-dev libmpc-dev 

# ---- Create a user account 'coco' for builds ----
useradd --shell /bin/bash -m coco
su - coco

# ---- Do the build ----
git clone https://github.com/strickyak/coco-shelf.git 
cd coco-shelf/
make
```

If that succeeded, the last two lines printed will be
```
make[1]: Leaving directory '/home/coco/coco-shelf/build-frobio'
date > done-frobio
```

Above that it lists the products of the frobio build,
which are in the `build-frobio` directory.

## Using your own github account

If you have a github account, you can clone the github
repos under your own username, by editing `conf.mk`
before typing your first `make`, changing these three lines:
```
COCO_TOOLSHED_REPO:=https://github.com/n6il/toolshed
COCO_NITROS9_REPO:=https://github.com/n6il/nitros9
COCO_FROBIO_REPO:=https://github.com/strickyak/frobio
```
to be like this:
```
COCO_TOOLSHED_REPO:=git@github.com:n6il/toolshed.git
COCO_NITROS9_REPO:=git@github.com:n6il/nitros9.git
COCO_FROBIO_REPO:=git@github.com:strickyak/frobio.git
```
You can also change your clone later by editing the
`.git/config` and changing the `url =` line.

And if you have your own copy of the repo in github
to push to, change the usernames `n6il` or `strickyak`
to your own github username.

## What is the mirror/ directory?

Because you might not be connected to the internet while
working on your coco (I often am not), everything you
need from the internet is fetched on your first `make`
and cached in the `mirror/` directory.  As of this writing,
that includes 3 tarballs and 3 github repositories.

If you start a new coco-shelf, you can copy (recursively)
the mirror directory into the new coco-shelf, or symlink it.
That will save time and bandwidth doing downloads, and will
work if you are not on the internet.

## Re-building portions.

If you delete one of the `done-*` files
( `done-cmoc done-frobio done-gccretro done-lwtools done-nitros9 done-toolshed` )
and type `make`, it will rebuild that portion of the shelf.

If you delete the source directory associated with one of those
portions and type `make`, it will make a new copy of that
directory from the mirror, and rebuild the portion.

## Freshening the mirrored portions.

If you want to freshen the git repos in the mirror,
you can chdir into the mirror directory and type `make pull`.
That will do a `git pull` in each repo.

If you want to use a new version of one of the tarballed
portions, change the version number in `conf.mk` and type
`make`.  It should fetch it.
