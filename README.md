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
