#!/usr/bin/env bash

echo "bootstrapping..."

# update apt sources
apt-get update
apt-get install apt-transport-https ca-certificates
apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
apt-get update

# install xenial prerequisites
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

# install docker
apt-get install -y docker-engine

# install some stuff i like
apt-get install -y git curl wget unzip tree

#create a docker group
groupadd docker
usermod -aG docker vagrant

# install docker compose
if [ $(which docker-compose) ]
  then
    echo "docker-compose executable detected...skipping install."
  else
    curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# install docker-machine
if [ $(which docker-machine) ]
  then
    echo "docker-machine executable detected...skipping install."
  else
    curl -L https://github.com/docker/machine/releases/download/v0.8.2/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine && \
    chmod +x /usr/local/bin/docker-machine
fi
