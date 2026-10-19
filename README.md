## Description

Highly hardened and tailored Linux Kernel for Intel laptops

This kernel also includes fixes for vswing/preemph tables  
Support for Goodix eSPI fingerprint reader (GXFP5130)  
Burst-Oriented Response Enhancer CPU Scheduler  
And support for some external hardware

## Support

Currently supported laptops

* Huawei Matebook D 14 2023 (MDF-XX)
* Huawei Matebook D 14 2024 (MDG-XX)

## External

List of external hardware support and features enabled

* Virtualization
* Kernel-based Virtual Machine (KVM) support
* Clang ThinLTO
* Default TCP congestion control BBR
* RFCOMM protocol support
* NT synchronization primitive emulation
* Universal TUN/TAP device driver support
* Realtek RTL8152/RTL8153 Based USB Ethernet Adapters
* CDC NCM support
* Huawei NCM embedded AT channel support
* Host for RNDIS and ActiveSync devices
* Allow to specify an EDID data set instead of probing for it
* Dummy BT SCO codec driver
* Wacom Intuos/Graphire tablet support (USB)
* USB Mass Storage support
* USB Attached SCSI
* USB Winchiphead CH341 Single Port Serial Driver
* Android Binder IPC Driver
* Android Binderfs filesystem
* exFAT filesystem support
* NTFS Read-Write file system support
* SquashFS 4.0 - Squashed file system support

External hardware support is being added on demand, I don't enable all possible hardware blindly  
If you need some external hardware support, you should open an issue

## Building

Clone this repository somewhere and run this command inside it to download Linux Kernel source  
You must have `devscripts` installed

```
uscan --download-current-version
```

You will see a directory named `linux-<version>` in the upper directory  
Go to it and simply run this command to build the packages

```
debuild -us -uc -ui -b
```

When the building is done you will see `.deb` files in the upper directory

## Why

All modern distributions provide generic kernel which prefers legacy and common drivers over modern alternatives and platform specific options, therefore I made this kernel to target specific platform utilizing modern drivers and platform specific options

What benefits will you get from this? In case with this kernel you will notice significantly better performance, smoother experience, faster system boot and significantly better power saving

Also unlike official Debian kernel you will get a seamless BGRT/Plymouth transition using modern EFI DRM instead of legacy EFI Framebuffer
