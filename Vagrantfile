# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dey/caliopen_full-ubuntu-14.04"
  config.vm.box_version = "0.2.0"
  config.vm.network :private_network, ip: "192.168.10.10"
  config.vm.synced_folder "./", "/vagrant"
  config.vm.provision :shell, path: ".vagrant/scripts/link-projects.sh"
end
