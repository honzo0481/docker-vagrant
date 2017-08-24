#!/usr/bin/env bash

echo "bootstrapping..."

# install packages
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# set up repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


# install docker
apt-get update
apt-get install -y docker-ce

# install some stuff i like
apt-get install -y wget unzip tree

#create a docker group
groupadd docker
usermod -aG docker ubuntu

# install docker compose
if [ $(which docker-compose) ]
  then
    echo "docker-compose executable detected...skipping install."
  else
    curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# install docker-machine
if [ $(which docker-machine) ]
  then
    echo "docker-machine executable detected...skipping install."
  else
    curl -L https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    cp /tmp/docker-machine /usr/local/bin/docker-machine
fi
