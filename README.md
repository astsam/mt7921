# Backport MT7921 driver
Install MT7921 driver from kernel 5.18.19 in older kernels. 
# How to install
```
$ sudo apt install build-essential
$ make
$ sudo make install
```
# How to uninstall
```
$ sudo make uninstall
```
Note: Firmware for MT7621 will not be uninstalled.
# Tested kernels
1. Kernel 5.15.0-56-generic (Linux Mint 20.3 Una)
2. Kernel 5.16.17-sun50iw6 (Orange Pi 3.0.8 Orangepi3-lts Ubuntu 22.04)
