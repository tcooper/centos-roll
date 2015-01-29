include version.mk

default: mirrorupdates

# Create the Base OS Roll
mirrorbase:
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(BASEPATH) arch=$(ARCH) rollname=$(DISTRO) version=$(VERSION)

# Add the Base OS Roll to distro
installbase: mirrorbase
	/sbin/service httpd stop
	/opt/rocks/bin/rocks add roll $(DISTRO)-$(VERSION)-*.iso
	/opt/rocks/bin/rocks enable roll $(DISTRO)-$(VERSION)
	/sbin/service httpd start

# Mirror Updates
mirrorupdates: 
	- /bin/rm Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(UPDATESPATH) arch=$(ARCH) rollname=Updates-$(DISTRO)-$(VERSION) version="`date +%Y.%m.%d`"

# Add updates to distro
installupdates: cleanupdates mirrorupdates
	- /sbin/service httpd stop
	/opt/rocks/bin/rocks add roll Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks enable roll Updates-$(DISTRO)-$(VERSION)
	-/sbin/service httpd start

# Remove All Previous Updates Rolls
cleanupdates:
	- /sbin/service httpd stop
	- /opt/rocks/bin/rocks remove roll Updates-$(DISTRO)-$(VERSION) arch=$(ARCH)
	- /sbin/service httpd start

testing:
	echo "arch is " $(ARCH)
	curl -I $(MIRRORURL)/$(BASEPATH)/centos-release-6-5.el6.centos.11.1.x86_64.rpm
	curl -I $(MIRRORURL)/$(UPDATESPATH)/centos-release-6-5.el6.centos.11.2.x86_64.rpm
