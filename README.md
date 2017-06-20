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
  software-properties-common \

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

#add user to docker group
sudo usermod -a -G docker ubuntu

# test
sudo docker run hello-world


```

- Install docker-compose

```sh
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

```

## Install and start C3S system

```sh
#add git to machine if needed
sudo apt-get -y install git

git clone https://github.com/c3s-magic/c3s-magic.git
cd cs3-magic
docker-compose up
```

- Allow https traffic to VM

```sh
sudo ufw allow 443/tcp
```



- Lets Encrypt!

Compose mounts letsencrypt specific .well-known folder for the challange


cd c3s-magic
sudo certbot certonly --webroot -w letsencrypt -d compute-test.c3s-magic.eu

#renew once in a while
certbot renew

#put key in keystore

#put key in truststore
keytool -delete -alias adagucservicescert -keystore config/portal/esg-truststore.ts -storepass changeit -noprompt
keytool -import -v -trustcacerts -alias adagucservicescert -file /etc/letsencrypt/live/compute-test.c3s-knmi.surf-hosted.nl/fullchain.pem -keystore config/portal/esg-truststore.ts -storepass changeit -noprompt
