# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-14.04"
  config.vm.network :private_network, ip: "192.168.10.10"
  config.vm.synced_folder "./", "/vagrant"
  config.vm.hostname = "caliopen-fullstack"
  config.vm.provision :ansible do |ansible|
    ansible.groups = {
      "backends" => ["default"],
      "webservers" => ["default"]
    }
    ansible.sudo = true
    ansible.playbook = "caliopen-ansible/single.yaml"
  end

  # for now cassandra requires at min 2GB  to run cf. https://github.com/CaliOpen/caliopen.web/issues/3#issuecomment-54809578
  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
  end
end
