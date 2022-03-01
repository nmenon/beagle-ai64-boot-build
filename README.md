Clone Instructions
==================


```
git clone https://github.com/nmenon/beagle-ai64-boot-build.git
cd beagle-ai64-boot-build
make gitsync
```

Build instructions
==================

Native compilation (default) on Beagle-Ai64:
--------------------------------------------

* aarch64-linux-gnu-
* arm-linux-gnueabihf-

```
make -j`nproc`
```

OR explicitly:

```
make CROSS_COMPILE_64=aarch64-linux-gnu- CROSS_COMPILE_32=arm-linux-gnueabihf- -j`nproc`
```

Cross Compiling:
----------------

Compiler: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads

* gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
* gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz

```
make CROSS_COMPILE_64=aarch64-none-linux-gnu- CROSS_COMPILE_32=arm-none-linux-gnueabihf- -j`nproc`
```

Flashing to emmc:
=================

Either copy the lnx-write-boot-emmc.sh and deploy folder to beagle-ai64 target OR
if you are building natively, then it is straightforward..

```
sudo ./lnx-write-boot-emmc.sh ./deploy
```
