VERSION="1.0.0"
help:
	@echo "make - show this help"
	@echo "make configure - load ansible configuration"
	@echo "make package - package caliopen in a fresh box"
	@echo ""
	@echo "git and ansible ~1.7 are required to run the process"

configure:
	#fixme submodule
	# git submodule init
	# git submodule update
	git clone https://github.com/CaliOpen/caliopen-ansible.git
	cp caliopen-ansible/group_vars/backends.tmpl caliopen-ansible/group_vars/backends
	cp caliopen-ansible/group_vars/vpnservers.tmpl caliopen-ansible/group_vars/vpnservers
	cp caliopen-ansible/group_vars/webservers.tmpl caliopen-ansible/group_vars/webservers
	#todo s/is_dev_env = false/is_dev_env = true/ :: caliopen-ansible/group_vars/webservers
	#TODO caliopen-ansible/host_vars/default :
	# private_ip_address: 192.168.10.10
	# datacenter: paris
	# rack: rack1

package:
	vagrant destroy
	vagrant up
	vagrant package --output caliopen_full-ubuntu-14.04_$(VERSION).box --vagrantfile includes/Vagrantfile \
		--include includes/init-caliopen.sh,includes/link-projects.sh,includes/start-caliopen.sh
