#!/usr/bin/env bash

apt-get update
apt-get install -y git
apt-get install -y tree
apt-get install -y curl
if [ $(which docker) ]
  then
    echo "no docker executable detected"
  else
    curl -sSL https://get.docker.com/ | sh
    usermod -aG docker vagrant
fi
if [ $(which docker-compose) ]
  then
    echo "no docker-compose executable detected"
  else
    curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi
if [ $(which docker-machine) ]
  then
    echo "no docker-machine executable detected"
  else
    curl -L https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine
    chmod +x /usr/local/bin/docker-machine
fi
