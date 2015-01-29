DISTRO        = CentOS
ARCH          = x86_64
VERSION       = 6.6
ifndef MIRRORURL
  MIRRORURL   =http://mirrors.kernel.org/centos
endif
BASEPATH      = $(VERSION)/os/$(ARCH)/Packages
UPDATESPATH   = $(VERSION)/updates/$(ARCH)/Packages
