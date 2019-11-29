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

# Mirror PowerTools Rocks7 Style
mirrorpowertoolsrocks7:
	-/bin/rm PowerTools-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(POWERTOOLSPATH) arch=$(ARCH) rollname=PowerTools-$(DISTRO)-$(VERSION) version=$(DATE) release=0

# Mirror AppStream Rocks7 Style
mirrorappstreamrocks7:
	-/bin/rm AppStream-$(DISTRO)-$(VERSION)-*.$(ARCH).*.iso
	/opt/rocks/bin/rocks create mirror $(MIRRORURL)/$(APPSTREAMPATH) arch=$(ARCH) rollname=AppStream-$(DISTRO)-$(VERSION) version=$(DATE) release=0

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

testing:
	echo "arch is " $(ARCH)
	curl -I $(MIRRORURL)/$(BASEPATH)/centos-release-8.0-0.1905.0.9.el8.x86_64.rpm
#	curl -I $(MIRRORURL)/$(UPDATESPATH)/<add_full_rpm_name_when_update_arrives>
	curl -I $(MIRRORURL)/$(POWERTOOLSPATH)/CUnit-devel-2.1.3-17.el8.x86_64.rpm
	curl -I $(MIRRORURL)/$(APPSTREAMPATH)/appstream-data-8-20180721.el8.noarch.rpm
