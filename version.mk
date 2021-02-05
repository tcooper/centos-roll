DISTRO        = CentOS
ARCH          = x86_64
VERSION       = 7.9.2009
DATE         :=$(shell date +%Y.%m.%d)
ifndef MIRRORURL
  MIRRORURL   =http://mirrors.ocf.berkeley.edu/centos
endif
BASEPATH      = $(VERSION)/os/$(ARCH)/Packages
UPDATESPATH   = $(VERSION)/updates/$(ARCH)/Packages
CRPATH        = $(VERSION)/cr/$(ARCH)/Packages
