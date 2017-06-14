# cs3-magic
Main System repo for C3S

# Setup

This system relies on two different systems, usually run as a docker container.

Note: this is very sparse on details.

Starting from plain ubuntu machine on SURFsara HPCcloud.

- Get ubuntu-server template
- Add data disk
- Boot
- update machine

```sh
sudo apt-get update
sudo apt-get upgrade
```

- set hostname
  vi /etc/hostname
  vi /etc/hosts 
- create partition on data disk: 
    fdisk /dev/vdb
- format data disk
    mkfs.ext4 /dev/vdb1
- add data disk to fstab
    mkdir /data
    vi /etc/fstab
- install docker (see https://store.docker.com/editions/community/docker-ce-server-ubuntu)

```sh
#install some tools
sudo apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

# add docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add docker repo
sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

# fetch packages
sudo apt-get update

# install
sudo apt-get -y install docker-ce

# test
sudo docker run hello-world


## Install system

git clone https://github.com/c3s-magic/c3s-magic.git
cd cs3-magic
docker-compose up


```
