#!/bin/sh

# simlink repositories from host machine to production path in VM

PROJECT_ROOT="/var/projects/caliopen/code"
#PROJECTS="caliopen.api caliopen.config caliopen.web caliopen.ng"
PROJECTS=$(ls $PROJECT_ROOT)

echo "create symlinks in $PROJECT_ROOT"

for PROJECT in $PROJECTS; do
    if [ -d /vagrant/$PROJECT ] && [ ! -h $PROJECT_ROOT/$PROJECT ];then
        echo "remove and add symlink for $PROJECT"
        rm -rf $PROJECT_ROOT/$PROJECT
        ln -s /vagrant/$PROJECT $PROJECT_ROOT/$PROJECT
        chown caliopen: $PROJECT_ROOT/$PROJECT
    fi
done
