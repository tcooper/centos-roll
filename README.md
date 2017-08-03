# CentOS Roll

## Purpose

This repository contains code that will help you create Rocks rolls for the
CentOS release and updates repository that you choose.

## Versions Supported

Each release of Rocks is targeted at a specific version of CentOS. The
following table illustrates the association of the recent Rocks/CentOS
releases and whether (or not) building CentOS/Updates-CentOS ISOs for that
version of Rocks is supported by this repository...

```
    Rocks 6.2 (Sidewinder)   -  CentOS 6.9  -  Supported in the 6.9 branch
    Rocks 6.2 (Sidewinder)   -  CentOS 6.8  -  Supported in the 6.8 branch
    Rocks 6.2 (Sidewinder)   -  CentOS 6.7  -  Supported in the 6.7 branch
    Rocks 6.2 (Sidewinder)   -  CentOS 6.6  -  Supported in the 6.6 branch
    Rocks 6.1.1 (Sand Boa)   -  CentOS 6.5  -  Supported in the 6.5 branch
    Rocks 6.1 (Emerald Boa)  -  CentOS 6.4  -  Unsupported
```

## Usage

Simply checkout the branch for the version of CentOS that you want to build
base or updates rolls for and do the following...

### Clone and checkout...

```
[tcooper@sandboa-fe1 tcooper]$ git clone https://github.com/tcooper/centos-roll.git
Cloning into 'centos-roll'...
remote: Counting objects: 116, done.
remote: Compressing objects: 100% (56/56), done.
remote: Total 116 (delta 54), reused 116 (delta 54), pack-reused 0
Receiving objects: 100% (116/116), 13.20 KiB, done.
Resolving deltas: 100% (54/54), done.

[tcooper@sandboa-fe1 tcooper]$ cd centos-roll/

[tcooper@sandboa-fe1 centos-roll]$ git checkout 6.5
Branch 6.5 set up to track remote branch 6.5 from origin.
Switched to a new branch '6.5'

```

### Make test...

Make sure your host has access to the configured mirror with the following...

```
[tcooper@sandboa-fe1 centos-roll]$ make testing
echo "arch is " x86_64
arch is  x86_64
curl -I http://vault.centos.org/6.5/os/x86_64/Packages/centos-release-6-5.el6.centos.11.1.x86_64.rpm
HTTP/1.1 200 OK
Date: Thu, 03 Aug 2017 17:46:03 GMT
Server: Apache/2.2.15 (CentOS)
Last-Modified: Wed, 27 Nov 2013 13:26:59 GMT
ETag: "25e1727-5150-4ec288d38cec0"
Accept-Ranges: bytes
Content-Length: 20816
Connection: close
Content-Type: application/x-rpm

curl -I http://vault.centos.org/6.5/updates/x86_64/Packages/centos-release-6-5.el6.centos.11.2.x86_64.rpm
HTTP/1.1 200 OK
Date: Thu, 03 Aug 2017 17:46:04 GMT
Server: Apache/2.2.15 (CentOS)
Last-Modified: Sun, 01 Dec 2013 18:33:24 GMT
ETag: "2620443-51e0-4ec7d4c6b2500"
Accept-Ranges: bytes
Content-Length: 20960
Connection: close
Content-Type: application/x-rpm
```

### Make the 'base' CentOS roll...

The mirrorbase target will build a roll from all RPMS in the 'os' directory of
the CentOS mirror for the version matching the branch you are in.

This only needs to be done once.

**NOTE: This will require enough space for TWO copies of all the RPMs in your
${PWD}. The mirrored RPM and the ISO with all mirrored RPMs. The ISOs range in
size from 5.1 GB for CentOS-6.5 to 5.5 GB for CentOS-6.9.**

```
[tcooper@sandboa-fe1 centos-roll]$ make mirrorbase
/opt/rocks/bin/rocks create mirror http://vault.centos.org/6.5/os/x86_64/Packages arch=x86_64 rollname=CentOS version=6.5
[sudo] password for tcooper:
Last-modified header missing -- time-stamps turned off.
2017-08-03 10:50:19 URL:http://vault.centos.org/6.5/os/x86_64/Packages/ [1641345] -> "vault.centos.org/6.5/os/x86_64/Packages" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 10:50:20 URL:http://vault.centos.org/6.5/os/x86_64/Packages/?C=N;O=D [1641345] -> "vault.centos.org/6.5/os/x86_64/Packages/index.html?C=N;O=D" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 10:50:20 URL:http://vault.centos.org/6.5/os/x86_64/Packages/?C=M;O=A [1641345] -> "vault.centos.org/6.5/os/x86_64/Packages/index.html?C=M;O=A" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 10:50:21 URL:http://vault.centos.org/6.5/os/x86_64/Packages/?C=S;O=A [1641345] -> "vault.centos.org/6.5/os/x86_64/Packages/index.html?C=S;O=A" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 10:50:21 URL:http://vault.centos.org/6.5/os/x86_64/Packages/?C=D;O=A [1641345] -> "vault.centos.org/6.5/os/x86_64/Packages/index.html?C=D;O=A" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 10:50:21 URL:http://vault.centos.org/6.5/os/x86_64/ [4671] -> "vault.centos.org/6.5/os/x86_64/index.html" [1]
2017-08-03 10:50:22 URL:http://vault.centos.org/6.5/os/x86_64/Packages/389-ds-base-1.2.11.15-29.el6.x86_64.rpm [1535388/1535388] -> "vault.centos.org/6.5/os/x86_64/Packages/389-ds-base-1.2.11.15-29.el6.x86_64.rpm" [1]

...<snip>...

Last-modified header missing -- time-stamps turned off.
2017-08-03 11:07:22 URL:http://vault.centos.org/6.5/os/x86_64/images/pxeboot/?C=S;O=D [2372] -> "vault.centos.org/6.5/os/x86_64/images/pxeboot/index.html?C=S;O=D" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 11:07:22 URL:http://vault.centos.org/6.5/os/x86_64/images/pxeboot/?C=D;O=D [2372] -> "vault.centos.org/6.5/os/x86_64/images/pxeboot/index.html?C=D;O=D" [1]
FINISHED --2017-08-03 11:07:22--
Downloaded: 6455 files, 5.6G in 0s (11192895299 GB/s)
Creating disk1 (0.00MB)...
Building ISO image for disk1 ...

[tcooper@sandboa-fe1 centos-roll]$ ls -l *.iso
-rw-r--r-- 1 root wheel 5467318272 Aug  3 11:10 CentOS-6.5-0.x86_64.disk1.iso

```

### Make the 'updates' CentOS roll...

The mirrorupdates target will build a roll from all RPMs in the 'updates' directory
of the CentOS mirror for the version matching the branch you are in.

This can be done each time you want to bring new updates to your system.

**NOTE: This will require enough space for TWO copies of all the RPMs in your
${PWD}. The mirrored RPM and the ISO with all mirrored RPMs. The ISOs range in
size from 1.2 GB for Updates-CentOS-6.9 to 2.0 GB for Updates-CentOS-6.7.**

```
[tcooper@sandboa-fe1 centos-roll]$ make mirrorupdates
/bin/rm Updates-CentOS-6.5-*.x86_64.*.iso
/bin/rm: cannot remove `Updates-CentOS-6.5-*.x86_64.*.iso': No such file or directory
make: [mirrorupdates] Error 1 (ignored)
/opt/rocks/bin/rocks create mirror http://vault.centos.org/6.5/updates/x86_64/Packages arch=x86_64 rollname=Updates-CentOS-6.5 version="`date +%Y.%m.%d`"
Last-modified header missing -- time-stamps turned off.
2017-08-03 13:57:02 URL:http://vault.centos.org/6.5/updates/x86_64/Packages/ [425833] -> "vault.centos.org/6.5/updates/x86_64/Packages" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 13:57:02 URL:http://vault.centos.org/6.5/updates/x86_64/Packages/?C=N;O=D [425833] -> "vault.centos.org/6.5/updates/x86_64/Packages/index.html?C=N;O=D" [1]

...<snip>...

Last-modified header missing -- time-stamps turned off.
2017-08-03 14:04:15 URL:http://vault.centos.org/6.5/updates/x86_64/repodata/?C=S;O=D [4594] -> "vault.centos.org/6.5/updates/x86_64/repodata/index.html?C=S;O=D" [1]
Last-modified header missing -- time-stamps turned off.
2017-08-03 14:04:15 URL:http://vault.centos.org/6.5/updates/x86_64/repodata/?C=D;O=D [4594] -> "vault.centos.org/6.5/updates/x86_64/repodata/index.html?C=D;O=D" [1]
FINISHED --2017-08-03 14:04:15--
Downloaded: 1643 files, 4.4G in 0s (8876965730 GB/s)
Creating disk1 (0.00MB)...
Building ISO image for disk1 ...

[tcooper@sandboa-fe1 centos-roll]$ ls -l *.iso
-rw-r--r-- 1 root wheel 1438046208 Aug  3 14:04 Updates-CentOS-6.5-2017.08.03-0.x86_64.disk1.iso
```
