# coco-shelf
A shelf for more-nearly-repeatable coco builds.

Note that the "MIT License" in thie file `LICENSE` refers to the
`coco-shelf` repository.  Other packages expaneded here have different
licenses, including some code under the GNU General Public License.

## Quick Start
Add tarfiles for the latest distrubution of
[CMOC](http://sarrazip.com/dev/cmoc.html)
and 
[LWTOOLS](http://www.lwtools.ca/)
like these.  Also the `gcc-4.6.4` distrubution, which is not at all recent.

```
cmoc-0.1.81.tar.gz
lwtools-4.21.tar.gz

gcc-4.6.4.tar.bz2
```

and type `make`.

Q: What extra packages need to be installed a current
Ubuntu or Debian linux distro?

* golang 1.18 or later
* buildtools
* git

For Ubuntu 22.10 x64 at Digital Ocean:

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
```

Now copy the `*.tar.*` files into the coco-shelf directory.
From another machine's coco-shelf, I do this (with the
name or the IP address of my new virtual machine):

`$ scp *.tar.* 134.209.76.3:coco-shelf`

Then run `make` in the coco-shelf:

```
$ cd coco-shelf/
$ make
```

## TODO

Look into something like
https://github.com/earthly/earthly
