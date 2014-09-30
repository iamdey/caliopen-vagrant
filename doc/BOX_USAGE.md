# Caliopen base box fullstack

Latest changes detailed in [CHANGELOG](https://github.com/esion/caliopen-vagrant/blob/master/CHANGELOG.md)

This a simple box with [caliopen](https://www.caliopen.org/) fullstack working :

1. Download and install [vagrant](http://vagrantup.com/) (this also works on windows, yep)
2. Create a directory then init & start the box

    ~~~
    vagrant init dey/caliopen_full-ubuntu-14.04
    vagrant up
    # FIXME : cannot login until reboot
    vagrant reload
    ~~~

3. Then open caliopen [https://192.168.10.10](https://192.168.10.10)
4. And connect with the default user has been added during the provisioning : vagrant@localhost / vagrant

## what works

* start caliopen full-stack on [192.168.10.10](https://192.168.10.10)
* nginx with selfsigned cert for https
* caliopen.web I guess
* authentication

## How to code caliopen

You can clone one or more projects of caliopen in the same directory of the Vagrantfile (host side), it will be linked to production path into VM
(The "magic" is in the file  `.vagrant/scripts/link-projects.sh`)

~~~
#host side
git clone https://github.com/CaliOpen/caliopen.web.git
git clone https://github.com/CaliOpen/caliopen.core.git
# ...
vagrant reload
~~~

At every boot vagrant will link caliopen repositories into vm production path (cf. provisioners packaged with box)

## Update the box

Simple as (beware, the box will be destroyed and recreated):

~~~
vagrant box update
~~~

## Create a user

~~~
vagrant ssh
sudo su - caliopen
cd /var/projects/caliopen/code/caliopen.web
caliopen -f production.ini setup
caliopen -f production.ini create_user
# then quit and reboot box:
vagrant reload
~~~

## run caliopen in dev env

the packaged vagrantfile always start pserve with prod config, you may want to run it manually :

kill the daemon then `/var/projects/caliopen/pserve.sh` or :

~~~
source /var/projects/caliopen/env/bin/activate
cd /var/projects/caliopen/code/caliopen.web
pserve --log-file pserve.log production.ini
~~~

## annexes

### I don't want Ubuntu, I want centos right now.

No problem, this box has been generated using the [caliopen-vagrant repository](https://github.com/esion/caliopen-vagrant). And can
be probably tweaked to run an other base box (e.g. centos ...), find yours in [vagrant cloud](https://vagrantcloud.com).

### troubleshoutings

**init-caliopen provision failed**

check /var/projects/caliopen/code/caliopen.web/caliopen.yaml :

~~~
index_server:
    url: http://192.168.10.10:9200

cassandra:
    keyspace: caliopen
    hosts:
        - '192.168.10.10:9160'
~~~

**sudo nginx -t**

> nginx: [emerg] SSL_CTX_use_PrivateKey_file ....

~~~
sudo rm /etc/nginx/certs/caliopen.crt
sudo rm /etc/nginx/certs/caliopen.key
~~~

then run ansible in local cf. README from caliopen-vagrant repository:

~~~
sudo ansible-playbook /vagrant/caliopen-ansible/single.yaml --connection=local -i ansible_inventory --tags=cert
~~~
