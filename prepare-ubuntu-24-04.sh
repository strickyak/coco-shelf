# Execute this script FIRST
# to install & update needed packages
# on Ubuntu 24.04 Noble (including LTS),
# before you use `make` in `coco-shelf/` the first time.
#
# Notice this first updates all your packages.
# You could leave out the first two commands,
# but that's generally a bad idea.

set -ex

sudo DEBIAN_FRONTEND=noninteractive  apt -y update < /dev/null
sudo DEBIAN_FRONTEND=noninteractive  apt -y upgrade < /dev/null
sudo DEBIAN_FRONTEND=noninteractive  apt -y install gcc make flex bison gdb build-essential
sudo DEBIAN_FRONTEND=noninteractive  apt -y install git golang zip curl python3-serial
sudo DEBIAN_FRONTEND=noninteractive  apt -y install libgmp-dev libmpfr-dev libmpc-dev libfuse-dev
sudo DEBIAN_FRONTEND=noninteractive  apt -y install cmake gcc-arm-none-eabi libusb-1.0-0-dev pkg-config

echo OKAY.
