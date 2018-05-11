#!/bin/bash

# Install KVM, etc.
APT=(
    gcc
    libsdl1.2-dev
    zlib1g-dev
    libasound2-dev
    linux-kernel-headers
    pkg-config
    libgnutls-dev
    libpci-dev
    libvirt-bin
    qemu-kvm
    linux-image-extra-$(uname -r)
    linux-image-extra-virtual
    apt-transport-https
    ca-certificates
    curl
    software-properties-common
)

apt-get update && apt-get install -y ${APT[*]}

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update && apt-get install docker-ce

# Install docker-machine-driver-kvm
curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-ubuntu14.04 > /usr/local/bin/docker-machine-driver-kvm 
chmod +x /usr/local/bin/docker-machine-driver-kvm

# Install kubectl
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubectl
echo "source <(kubectl completion bash)" >> ~/.bashrc

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.26.1/minikube-linux-amd64 && chmod +x minikube && mv minikube /usr/local/bin/

# Install MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Install python dependencies
PIP3=(
    flask
    gevent
    youtube-dl
    pafy
    pymongo
)

pip3 install ${PIP3[*]}
