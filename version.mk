DISTRO        = CentOS
ARCH          = x86_64
VERSION       = 6.5
ifndef MIRRORURL
  MIRRORURL   = http://vault.centos.org
endif
BASEPATH      = $(VERSION)/os/$(ARCH)/Packages
UPDATESPATH   = $(VERSION)/updates/$(ARCH)/Packages
