include version.mk

default: mirrorupdates

# Create the Base OS Roll
mirrorbase:
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(BASEPATH) arch=$(ARCH) rollname=$(DISTRO) version=$(VERSION) release=$(DATE)

# Add the Base OS Roll to distro
installbase: mirrorbase
	/sbin/service httpd stop
	/opt/rocks/bin/rocks add roll $(DISTRO)-$(VERSION)-*.iso
	/opt/rocks/bin/rocks enable roll $(DISTRO)-$(VERSION)
	/sbin/service httpd start

# Mirror Updates
mirrorupdates: 
	- /bin/rm Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(UPDATESPATH) arch=$(ARCH) rollname=Updates-$(DISTRO) version=$(VERSION) release=$(DATE)

# Remove All Previous Updates Rolls
cleanupdates:
	- /sbin/service httpd stop
	- /opt/rocks/bin/rocks remove roll Updates-$(DISTRO)-$(VERSION) arch=$(ARCH)
	- /sbin/service httpd start

# Add updates to distro
installupdates: cleanupdates mirrorupdates
	- /sbin/service httpd stop
	/opt/rocks/bin/rocks add roll Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks enable roll Updates-$(DISTRO)-$(VERSION)
	-/sbin/service httpd start

testing:
	echo "arch is " $(ARCH)
	curl -I $(MIRRORURL)/$(BASEPATH)/centos-release-6-7.el6.centos.12.3.x86_64.rpm
	curl -I $(MIRRORURL)/$(UPDATESPATH)/virt-p2v-0.9.1-2.20130730.1.el6.centos.noarch.rpm
