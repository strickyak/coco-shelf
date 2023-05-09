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
