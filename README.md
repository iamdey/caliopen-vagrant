# A vagrant box to dev caliopen

This is the Vagrantfile for [caliopen](https://www.caliopen.org/) fullstack [box](https://vagrantcloud.com/dey/caliopen_full-ubuntu-14.04)

The main goal of this repository is to build a new release of **caliopen box.**

## Package a new caliopen box

Update the version of the box :

~~~
#includes/Vagrantfile
config.vm.box_version = "{semver}"
~~~

~~~
#Makefile
VERSION="{semver}"
~~~

Then launch the following commands

~~~
vagrant destroy
make configure
make package
~~~

this will :

1. eventually destroy previous box
2. clone calipopen-ansible repository and prepare config files
3. up and provision a box with ansible
4. package it


## Simple provision a new fresh box

~~~
make configure
vagrant destroy
vagrant up
~~~

## Tips

### Rewrite nginx cert

~~~
vagrant up
vagrant ssh -c "sudo rm /etc/nginx/certs/caliopen.crt"
vagrant ssh -c "sudo rm /etc/nginx/certs/caliopen.key"
vagrant ssh -c "sudo ansible-playbook /vagrant/caliopen-ansible/single.yaml --connection=local --tags=cert"
~~~

### Ansible in VM

Since ansible is installed in VM, it can be launched on VM itself

~~~
#ansible_inventory
default ansible_ssh_host=127.0.0.1 ansible_ssh_port=22

[backends]
default

[webservers]
default
~~~

~~~
sudo ansible-playbook /vagrant/caliopen-ansible/single.yaml --connection=local -i ansible_inventory
~~~

## TODO

**provision** : [install ansible from source](http://docs.ansible.com/intro_installation.html)

then run:

~~~
source path-to-ansible/hacking/env-setup
~~~

**use caliopen user** in vagrantfile use to package box

~~~
config.vm.synced_folder "./", "/vagrant", owner: "caliopen", group: "caliopen"
~~~

**make sure pserve is started optionnaly in target box**
