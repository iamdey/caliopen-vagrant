#!/bin/bash

#fixme bcrypt lib owned by root
sudo chown -R vagrant: /var/projects/caliopen/env/lib/

CALIOPEN_PATH=/var/projects/caliopen/code/caliopen.web

source /var/projects/caliopen/env/bin/activate

caliopen -f $CALIOPEN_PATH/production.ini setup
caliopen -f $CALIOPEN_PATH/production.ini create_user -e vagrant@localhost -p vagrant -f vag -l rant
