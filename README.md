# coco-shelf
A shelf for more-nearly-repeatable coco builds.

Note that the "MIT License" in thie file `LICENSE` refers to the
`coco-shelf` repository.  Other packages expaneded here have different
licenses, including some code under the GNU General Public License.

## Quick Start
Just type `make`.  Let me know what goes wrong!

## Example: For Ubuntu 22.10 x64 at Digital Ocean:

```
---- Install needed linux packages ----
# apt update
# apt upgrade
# apt install gcc gcc-doc make flex bison gdb build-essential
# apt install git git-doc golang golang-doc
# apt install libgmp-dev libmpfr-dev libmpc-dev 

---- Create a user account for builds ----
# useradd -m strick
# mkdir ~strick/.ssh
# cp -av .ssh/authorized_keys ~strick/.ssh/
'.ssh/authorized_keys' -> '/home/strick/.ssh/authorized_keys'
# chown -R strick ~strick/.ssh/

---- Use the user account for builds ----
# su - strick

$ git clone https://github.com/strickyak/coco-shelf.git 
$ cd coco-shelf/
$ make
```

## TODO

Look into something like
https://github.com/earthly/earthly ?
