include version.mk

default: testing mirrorupdatesrocks7

MTIME_VAL=7

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
	-/bin/rm Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(UPDATESPATH) arch=$(ARCH) rollname=Updates-$(DISTRO) version=$(VERSION) release=$(DATE)

# Mirror Updates Rocks7 Style
mirrorupdatesrocks7:
	-/bin/rm Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(UPDATESPATH) arch=$(ARCH) rollname=Updates-$(DISTRO)-$(VERSION) version=$(DATE) release=0

# Mirror CR
mirrorcr: 
	-/bin/rm CR-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(CRPATH) arch=$(ARCH) rollname=CR-$(DISTRO) version=$(VERSION) release=$(DATE)

# Remove All Previous Updates Rolls
cleanupdates:
	-/sbin/service httpd stop
	-/opt/rocks/bin/rocks remove roll Updates-$(DISTRO)-$(VERSION) arch=$(ARCH)
	-/sbin/service httpd start

# Add updates to distro
installupdates: cleanupdates mirrorupdates
	- /sbin/service httpd stop
	/opt/rocks/bin/rocks add roll Updates-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks enable roll Updates-$(DISTRO)-$(VERSION)
	-/sbin/service httpd start

# Check for new RPMs
newrpms:
	find . -name *.rpm -mtime -$(MTIME_VAL) | xargs rpm -q --qf %{NAME}\\n -p | sort -u | column -c 120

# Upload ISO to Lustre
upload:
	rsync -avz *.iso oasis-dm-interactive.sdsc.edu:/oasis/projects/nsf/sys200/tcooper/rolls/$(DISTRO)/$(VERSION)/

#
testing:
	echo "arch is " $(ARCH)
	curl -I $(MIRRORURL)/$(BASEPATH)/centos-release-7-8.2003.0.el7.centos.x86_64.rpm
	curl -I $(MIRRORURL)/$(UPDATESPATH)/bind-9.11.4-16.P2.el7_8.2.x86_64.rpm
