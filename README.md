# coco-shelf
A shelf for more-nearly-repeatable coco builds.

Note that the "MIT License" in thie file `LICENSE` refers to the
`coco-shelf` repository.  Other packages expaneded here have different
licenses, including some code under the GNU General Public License.

## Quick Start
Just type `make`.  Let me know what goes wrong!

It can take 8 minutes or more to build everything,
and it needs perhaps 1.7 GB of disk.

## Example: For Ubuntu 22.10 x64 at Digital Ocean:

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

## TODO

Look into something like
https://github.com/earthly/earthly ?
