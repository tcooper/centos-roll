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

