# Caliopen base box fullstack

This a simple box with [caliopen](https://www.caliopen.org/) fullstack working :

1. Download and install [vagrant](http://vagrantup.com/) (this also works on windows, yep)
2. Create a directory then init & start the box

    ~~~
    vagrant init dey/caliopen_full-ubuntu-14.04
    vagrant up
    ~~~

3. It's a bit more tricky (I'll work on this) :

    ~~~
    vagrant ssh
    sudo su - caliopen
    /var/projects/caliopen/pserve.sh
    ~~~

4. Then open caliopen [https://192.168.10.10](https://192.168.10.10)

## what works

* start caliopen full-stack on [192.168.10.10](https://192.168.10.10)
* nginx with selfsigned cert for https
* caliopen.web I guess

## How to code caliopen

You can clone one or more projects of caliopen in the same directory of the Vagrantfile (host side), it will be linked to production path into VM
(The "magic" is in the file  `.vagrant/scripts/link-projects.sh`)

~~~
#host side
git clone https://github.com/CaliOpen/caliopen.web.git
git clone https://github.com/CaliOpen/caliopen.core.git
# ...
vagrant reload --provision
~~~

## Update the box

Simple as (beware, the box will be destroyed and recreated):

~~~
vagrant box update
~~~

## annexes

the original box is from "chef/ubuntu-14.04" plus the [ansible config of caliopen](https://github.com/CaliOpen/caliopen-ansible).
