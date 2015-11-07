#!/usr/bin/env bash

apt-get update
apt-get install -y git
apt-get install -y tree
apt-get install -y curl
apt-get install -y wget
apt-get install -y unzip

if [ $(which docker) ]
  then
    echo "docker executable detected...skipping install."
  else
    wget -qO- https://get.docker.com/ | sh
    usermod -aG docker vagrant
fi
if [ $(which docker-compose) ]
  then
    echo "docker-compose executable detected...skipping install."
  else
    curl -L https://github.com/docker/compose/releases/download/1.5.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi
if [ $(which docker-machine) ]
  then
    echo "docker-machine executable detected...skipping install."
  else
    curl -L https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_linux-amd64.zip >machine.zip && \
    unzip machine.zip && \
    rm machine.zip && \
    mv -f docker-machine* /usr/local/bin
fi
