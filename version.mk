DISTRO        = CentOS
ARCH          = x86_64
VERSION       = 6.8
DATE         :=$(shell date +%Y.%m.%d)
ifndef MIRRORURL
  MIRRORURL   =http://mirror.hmc.edu/centos
endif
BASEPATH      = $(VERSION)/os/$(ARCH)/Packages
UPDATESPATH   = $(VERSION)/updates/$(ARCH)/Packages
