DISTRO        = CentOS
ARCH          = x86_64
VERSION       = 8.0.1905
DATE         :=$(shell date +%Y.%m.%d)
ifndef MIRRORURL
  MIRRORURL   =http://mirrors.ocf.berkeley.edu/centos
endif
BASEPATH      = $(VERSION)/BaseOS/$(ARCH)/os/Packages
UPDATESPATH   = $(VERSION)/BaseOS/$(ARCH)/updates/Packages
APPSTREAMPATH = $(VERSION)/AppStream/$(ARCH)/os/Packages
POWERTOOLSPATH = $(VERSION)/PowerTools/$(ARCH)/os/Packages
