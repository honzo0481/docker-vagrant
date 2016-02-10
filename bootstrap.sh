#!/usr/bin/env bash

# update apt sources
apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F76221572C52609D
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
touch /etc/apt/sources.list.d/docker.list
chown vagrant:vagrant /etc/apt/sources.list.d/docker.list
echo deb https://apt.dockerproject.org/repo ubuntu-trusty main> /etc/apt/sources.list.d/docker.list

# update package mgr and install prereqs
apt-get update
apt-get purge lxc-docker
apt-get install -y linux-image-extra-$(uname -r) apparmor

# install docker
apt-get install -y docker-engine

# install some stuff that i like
apt-get install -y git tree curl wget unzip

# Create a Docker group
usermod -aG docker vagrant

# install docker-compose
if [ $(which docker-compose) ]
  then
    echo "docker-compose executable detected...skipping install."
  else
    curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# install docker-machine
if [ $(which docker-machine) ]
  then
    echo "docker-machine executable detected...skipping install."
  else
    curl -L https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
    chmod +x /usr/local/bin/docker-machine
fi
