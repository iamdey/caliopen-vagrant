# A vagrant box to dev caliopen

This is the Vagrantfile of [caliopen](https://www.caliopen.org/) fullstack [box](https://vagrantcloud.com/dey/caliopen_full-ubuntu-14.04)

**The main goal of this repository is to build a new release of caliopen box.**

## Package a new caliopen box

* clone calipopen-ansible repository

~~~
git clone https://github.com/CaliOpen/caliopen-ansible.git
~~~

* Then apply the magic configuration for vagrant:

  ~~~
  WIP
  ~~~

* Make sure the current box has caliopen project repository linked to production path
* Run ansible in VM (the command is idempotent)

  ~~~
  vagrant up
  vagrant ssh -c "sudo rm /etc/nginx/certs/caliopen.crt"
  vagrant ssh -c "sudo rm /etc/nginx/certs/caliopen.key"
  vagrant ssh -c "sudo ansible-playbook /vagrant/caliopen-ansible/single.yaml --connection=local"
  ~~~

* Repackage the box

  ~~~
  vagrant package --output caliopen_full-ubuntu-14.04_{x.y.z}.box --vagrantfile Vagrantfile --include .vagrant/scripts/link-projects.sh
  ~~~
